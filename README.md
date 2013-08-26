# Fuzzy logic "Fuzzy Associative Memory"

A Fuzzy Associative Memory (FAM for short) is a Fuzzy Logic tool for decision
making. Fuzzy logic FAMs have a wide range of practical applications:

* Control systems, such as governing a fan to keep a room at the "just right" temperature
* Game AI, such as imbuing bots with human-like decision-making behavior
* Prediction systems, linking causes with effects
 
## How it works

A Fuzzy Associative Memory uses Fuzzy Sets to establish a set of rules that are linguistic in nature; examples might include:

* "If the room is a bit warm, turn the fan up a little bit"
* "If the orc's hit points are a little low, retreat from the enemy"
* "If the enemy is distant and my rocket ammo is low, the rocket launcher is a poor choice"
* "If the enemy is near and my shotgun ammo is okay, the shotgun is a very desirable choice"
* "If the ship is off course by a little bit, correct just a little to the right"
* "If the bird is much slower than the flock, speed it up a lot"

The linguistic rules, and the fuzzy sets they contain, are defined by a human "expert" (presumably, you). That is to say,
the rules *codify intelligence* and map this knowledge from the human domain to the digital. 

After the rules are defined, a FAM is consulted to help your AI make a descision:
* The orc retreats, attacks, strafes.
* The ship launches long range missiles or fires short range guns.
* The control rods are lowered into the reactor or raised out of it.

As you can see, the fuzzy rules are deliberately vague and use qualifiers like "a little" and "a lot". Furthermore, the lines
between fuzzy sets are intentionally blurry. This is the nature of fuzzy sets; they capture such human fuzziness in a way that extracts highly natural behavior from the fuzzy rules.
When defining these rules, it helps to imagine interviewing a bona fide expert in the domain and writing down the skills necessary to be successful in the domain.

## FLV visualization

Fuzzy Linguistic Variables can be hard to visualize, especially when they get complex and include triangles and trapezoids in combination.
To answer that, this software can now (optionally) shell out to your installed Gnuplot and create PNG or SVG renderings of your FLVs. Here's an example:

![flv example](https://raw.github.com/cpowell/fuzzy-associative-memory/master/bin/plot%20of%20rocket%20launcher%20ammo%20quantity.png)

## Project status

This is working, functional software, suitable for use in your own game or application. It currently supports:
* Triangular & trapezoidal fuzzy sets for input/output
* Larsen Implication (scaling)
* Mamdani Implication (clipping)
* Atomic antecedent propositions (`if A then Z`)
* Composite antecedent propositions (`if A or B, then Z` / `if A and B, then Z`)

To do (in descending importance, roughly):
* Parameter validations to prevent bad shapes, improper FAM layout, etc.
* Other shapes for fuzzy sets
* Hedges ('very' and 'fairly')
* Additional examples
 
Watch the [changelog](http://github.com/cpowell/fuzzy-associative-memory/blob/master/CHANGELOG.md) for news.

## Gem installation

I recommend you clone the Git repository and browse the examples and source code to fully understand how FAMs work.

But if / when you want to use this in your own project, the easiest way to do so is via the Gem:
```
gem install fuzzy_associative_memory
```

Then in your code:
```
require 'fuzzy_associative_memory'
```

The gem is fully namespaced to prevent collisions. See the examples for usage details.

## Included examples

The `bin` directory contains the following examples:
* `hvac_system_example` illustrates how a FAM could govern an HVAC fan unit to maintain a constant, comfortable temperature
* `weapon_choice_example` illustrates how a FAM could let a game bot intelligently decide which weapon to use

Plots of the examples' fuzzy linguistic variables have been pre-rendered and are in the bin directory. These will help you visualize the FLVs.

## References used in the creation of this software
* "Fuzzy Thinking: The New Science of Fuzzy Logic" by Bart Kosko [(Amazon link)](http://www.amazon.com/Fuzzy-Thinking-New-Science-Logic/dp/0006547133/)
* "Fuzzy Logic: The Revolutionary Computer Technology that is Changing the World" by Daniel McNeill & Paul Freiberger [(Amazon link)](http://www.amazon.com/Fuzzy-Logic-Revolutionary-Computer-Technology/dp/0671875353/)
* "Fuzzy Logic in Decision Making and Signal Processing" by Sujit Nath Pant & Keith E. Holbert [(Link)](http://enpub.fulton.asu.edu/powerzone/fuzzylogic/index.htm)
* "Programming Game AI by Example" by Mat Buckland [(Amazon link)](http://www.amazon.com/Programming-Game-Example-Mat-Buckland/dp/1556220782)


[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/cpowell/fuzzy-associative-memory/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

