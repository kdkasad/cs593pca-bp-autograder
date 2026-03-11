# CS 593PCA BP auto-grader

A Gradescope auto-grader for CS 593PCA's branch predictor competition
assignment.

## Submission format

Submit a single `.hpp` file which contains your branch predictor class.
The class must have the same name as the file, and must provide defaults for all
template parameters.
E.g., if you submit `mypred.hpp`, your predictor class must be named `mypred`
and must be constructible as `mypred<>`.

The file will be copied into the `predictors/` directory of the [cbp-ng]
repository, and compiled using `./compile cbp -DPREDICTOR="FILENAME<>"`.

[cbp-ng]: https://github.com/AmpereComputing/cbp-ng

## Grading results

Your score will be 1/1 if your predictor compiles and runs successfully, or 0/1
if it fails to do either.

The performance results do not affect your score; they are printed in the test
case results and sent to the leaderboard.

## Viewing the leaderboard

Gradescope will only show the leaderboard after you have submitted.
See [Gradescope's documentation on the topic](https://gradescope-autograders.readthedocs.io/en/latest/leaderboards/#student-submission).

For the numbers on the leaderboard, lower is better for everything except the
VFS score, for which higher is better.
