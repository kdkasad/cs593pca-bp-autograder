FROM gradescope/autograder-base:ubuntu-22.04
WORKDIR /autograder

# Install g++-12 and jq
RUN \
	add-apt-repository -y ppa:ubuntu-toolchain-r/test \
	&& apt-get install -y jq g++-12 \
	&& rm -rf /var/lib/apt/lists/*

# Set g++-12 as default g++
RUN update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-12 12
RUN update-alternatives --set g++ /usr/bin/g++-12

# Create student user
RUN adduser student --no-create-home --disabled-password

# Clone cbp-ng repository
ADD --chmod=ug=rwX,o=rX https://github.com/AmpereComputing/cbp-ng.git /autograder/source/cbp-ng
WORKDIR /autograder/source/cbp-ng

# Apply diff
COPY disable-cheating.diff /tmp/disable-cheating.diff
RUN git apply /tmp/disable-cheating.diff

# Create auxiliary directories
RUN umask 002 && mkdir traces results
RUN umask 002 && ln -s gcc_test_trace.gz traces/

WORKDIR /autograder
COPY run_autograder .
RUN chmod +x run_autograder
