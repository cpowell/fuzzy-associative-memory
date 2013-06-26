# Fuzzy Associative Memory

A Fuzzy Associative Memory (FAM for short) is a Fuzzy Logic tool for decision
making. It uses Fuzzy Sets to establish a set of rules that are linguistic in nature; examples might include:

* "If the room is a bit warm, turn the fan up a little bit"
* "If the orc's hit points are a little low, retreat from the enemy"
* "If the enemy is distant and my rocket ammo is low, the rocket launcher is a poor choice"
* "If the enemy is near and my shotgun ammo is okay, the shotgun is a very desirable choice"
* "If the ship is off course by a little bit, correct just a little to the right"
* "If the bird is much slower than the flock, speed it up a lot"

As you can see, the rules are deliberately vague and use qualifiers like "a little" and "a lot". This is the nature of fuzzy sets; they capture such human fuzziness in a way that extracts highly natural behavior from the fuzzy rules.

It has a wide range of applications:

* Control systems, such as governing a fan to keep a room at the "just right" temperature
* Game AI, such as giving human-like behavior capabilities to NPCs
* Prediction systems

## Status

This is working, functional software. It currently supports:
* Triangular & trapezoidal fuzzy sets for input/output
* Larsen Implication (scaling)
* Atomic antecedent propositions (`if A then Z`)
* Composite antecedent propositions (`if A or B, then Z` / `if A and B, then Z`)

To do:
* Other shapes for fuzzy sets
* Hedges ('very' and 'fairly')
* Mamdani Implication (clipping)
* Parameter validations to prevent bad shapes, improper FAM layout, etc.
* Additional examples

## Examples

The `bin` directory contains the following examples:
* `hvac_system_example` illustrates how a FAM could govern an HVAC fan unit to maintain a constant, comfortable temperature
* `weapon_choice_example` illustrates how a FAM could let a game bot intelligently decide which weapon to use

## References used in the creation of this software
* ["Fuzzy Thinking: The New Science of Fuzzy Logic" by Bart Kosko](http://www.amazon.com/Fuzzy-Thinking-New-Science-Logic/dp/0006547133/)
* ["Fuzzy Logic: The Revolutionary Computer Technology that is Changing the World" by Daniel McNeill & Paul Freiberger](http://www.amazon.com/Fuzzy-Logic-Revolutionary-Computer-Technology/dp/0671875353/)
* ["Fuzzy Logic in Decision Making and Signal Processing" by Sujit Nath Pant & Keith E. Holbert"](http://enpub.fulton.asu.edu/powerzone/fuzzylogic/index.htm)
* ["Programming Game AI by Example" by Mat Buckland](http://www.amazon.com/Programming-Game-Example-Mat-Buckland/dp/1556220782)
