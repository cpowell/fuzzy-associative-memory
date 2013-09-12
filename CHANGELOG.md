# Changelog for fuzzy-associative-memory

## 1.3.2, 12 September 2013
* Correct a regression in Rule

## 1.3.1, 2 September 2013
* Massive performance and efficiency effort. This version of the Gem clocks in at 3.5x the speed of my 1.1 series in synthetic benchmarks. If you use the FAM in a tight loop, this will help a lot.

## 1.2.0, 23 August 2013
* RuleSet::calculate() gets a refactor / efficiency rewrite
* Argument sanity-checking
* Improvements to Gnuplot visualization (logarithmic axis, return filename to caller)

## 1.1.0, 26 July 2013
* Fuzzy Linguistic Variables are hard to visualize, especially when they get complex. To remedy that, you can now instruct an FLV to shell out to your installed Gnuplot and plot itself. The images are saved in your system's tmpdir.

## 1.0.1, 28 June 2013
* Based on good feedback, revised the initializer for `Rule` to put the `natural_language` parameter at the end and make it optional. I realize this is a disruptive alteration to the API and I apologize for the code adjustments this will necessitate. (I had to pay the penance of refactoring a lot of my own code, if that helps.)

## 1.0.0, 26 June 2013
* Initial Gem release
