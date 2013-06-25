# Fuzzy Associative Memory

A Fuzzy Associative Memory (FAM for short) is a Fuzzy Logic tool for decision
making. It has a wide range of applications:

* Industrial control, such as governing a fan to keep a room at the "just right" temperature
* Game AI, such as giving human-like behavior capabilities to NPCs
* Prediction systems

## Status

This is working, functional software. It currently supports:
* Triangular fuzzy sets for input/output
* Larsen Implication (scaling)
* Atomic antecedent propositions (`if A then Z`)

To do:
* Trapezoidal (and other shapes) for fuzzy sets
* Hedges ('very' and 'fairly')
* Mamdani Implication (clipping)
* Composite antecedent propositions (`if A or B, then Z` / `if A and B, then Z`)
* Additional examples

## Examples

The `bin` directory contains the following examples:
* `hvac_system_example` illustrates how a FAM could govern an HVAC fan unit to maintain a constant, comfortable temperature

## References used in the creation of this software
* ["Fuzzy Thinking: The New Science of Fuzzy Logic" by Bart Kosko](http://www.amazon.com/Fuzzy-Thinking-New-Science-Logic/dp/0006547133/)
* ["Fuzzy Logic: The Revolutionary Computer Technology that is Changing the World" by Daniel McNeill & Paul Freiberger](http://www.amazon.com/Fuzzy-Logic-Revolutionary-Computer-Technology/dp/0671875353/)
 



