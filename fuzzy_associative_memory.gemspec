Gem::Specification.new do |s|
  s.name        = 'fuzzy_associative_memory'
  s.version     = '1.2.0'
  s.date        = '2013-08-23'
  s.summary     = "A fuzzy logic 'Fuzzy Associative Memory' (FAM) for fuzzy control systems, decision-making, artificial intelligence / AI, game agents & bots, etc."
  s.description = <<-EOF
    A Fuzzy Associative Memory (FAM for short) is a Fuzzy Logic tool for decision making. Fuzzy logic FAMs have a wide range of practical applications: Control systems, such as governing a fan to keep a room at the "just right" temperature; Game AI, such as imbuing bots with human-like decision-making behavior; Prediction systems, linking causes with effects. A FAM uses Fuzzy Sets to establish a set of rules that are linguistic in nature. The linguistic rules, and the fuzzy sets they contain, are defined by a human "expert" (presumably, you). The rules therefore codify intelligence and map this knowledge from the human domain to the digital.
  EOF
  s.authors     = ["Chris Powell"]
  s.email       = 'cpowell@prylis.com'
  s.files       = Dir['lib/**/*.rb'] + Dir['bin/*']
  s.files       += Dir['[A-Z]*'] + Dir['test/**/*']
  s.homepage    = 'http://github.com/cpowell/fuzzy-associative-memory'
  s.license     = 'LGPL'
  s.rdoc_options = ["--main", "README.md"]
end
