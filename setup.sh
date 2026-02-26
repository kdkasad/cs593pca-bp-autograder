#!/bin/bash

set -e -u -o pipefail -x
umask 007

# Create student user to avoid running their code as root
adduser student --no-create-home --disabled-password

# Install tools needed in grader script
add-apt-repository -y ppa:ubuntu-toolchain-r/test
apt-get install -y jq g++-13
update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-13 13
update-alternatives --set g++ /usr/bin/g++-13

# Clone cbp-ng repository
(
	umask 002  # Allow student to access
	mkdir -p /autograder/source
	cd /autograder/source
	git clone --depth 1 https://github.com/AmpereComputing/cbp-ng.git cbp-ng
	cd cbp-ng
	mkdir traces results
	ln gcc_test_trace.gz traces/
)
