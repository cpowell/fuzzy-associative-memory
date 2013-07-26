# Changelog for fuzzy-associative-memory

## 1.1, 26 July 2013
* Fuzzy Linguistic Variables are hard to visualize, especially when they get complex. To remedy that, you can now instruct an FLV to shell out to your installed Gnuplot and plot itself. The images are saved in your system's tmpdir.

## 1.0.1, 28 June 2013
* Based on good feedback, revised the initializer for `Rule` to put the `natural_language` parameter at the end and make it optional. I realize this is a disruptive alteration to the API and I apologize for the code adjustments this will necessitate. (I had to pay the penance of refactoring a lot of my own code, if that helps.)

## 1.0.0, 26 June 2013
* Initial Gem release
