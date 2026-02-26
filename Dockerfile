FROM gradescope/autograder-base:ubuntu-22.04
WORKDIR /autograder

# This doesn't need to be its own step but it speeds up the build due to caching
RUN add-apt-repository -y ppa:ubuntu-toolchain-r/test \
	&& apt-get install -y g++-12 \
	&& rm -rf /var/lib/apt/lists/*

COPY setup.sh .
RUN apt-get update \
	&& bash -x ./setup.sh \
	&& rm -rf /var/lib/apt/lists/*
COPY run_autograder .
RUN chmod +x run_autograder
