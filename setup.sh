#!/bin/bash

set -e -u -o pipefail -x
umask 007

# Create student user to avoid running their code as root
adduser student --no-create-home --disabled-password

# Install tools needed in grader script
add-apt-repository -y ppa:ubuntu-toolchain-r/test
apt-get install -y jq g++-12
update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-12 12
update-alternatives --set g++ /usr/bin/g++-12

# Clone cbp-ng repository
(
	umask 002  # Allow student to access
	mkdir -p /autograder/source
	cd /autograder/source
	git clone --depth 1 https://github.com/AmpereComputing/cbp-ng.git cbp-ng
	cd cbp-ng
	git apply << 'EOF'
diff --git a/harcom.hpp b/harcom.hpp
index 0f2b550736..19a3840e0a 100644
--- a/harcom.hpp
+++ b/harcom.hpp
@@ -24,6 +24,12 @@
 #ifndef HARCOM_H
 #define HARCOM_H

+#undef FREE_FANOUT
+#undef CHEATING_MODE
+#undef FLOORPLAN
+#undef FREE_WIRING
+#undef READ_WRITE_RAM
+
 #include <cstdint>
 #include <cassert>
 #include <cmath>

EOF
	mkdir traces results
	ln gcc_test_trace.gz traces/
)
