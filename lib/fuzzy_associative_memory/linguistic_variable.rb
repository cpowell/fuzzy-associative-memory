#
# Copyright 2013, Prylis Incorporated.
#
# This file is part of The Ruby Fuzzy Associative Memory
# http://github.com/cpowell/fuzzy-associative-memory
# You can redistribute and/or modify this software only in accordance with
# the terms found in the "LICENSE" file included with the library.
#
require 'tempfile'

class FuzzyAssociativeMemory::LinguisticVariable
  attr_accessor :sets
  attr_reader :name

  def initialize(name)
    @name       = name
    @sets = []
  end

  def add_set(set)
    @sets << set
  end

  # Shell out to your system's installed Gnuplot binary to create a graphical depiction
  # of this FLV.
  #
  # * *Args*    :
  #   - +options+ -> a hash of options; see below
  #
  def gnuplot(options = {})
    return if @sets.empty?

    opts = {
      :logarithmic_x => false # Default to non-log X axis
    }.merge(options)

    datafile = Tempfile.new('fam_')
    begin
      @sets.each_with_index do |s, i|
        if s.is_a? FuzzyAssociativeMemory::Triangle
          datafile.puts "Set#{i} #{s.left} 0"
          datafile.puts "Set#{i} #{s.center} 1"
          datafile.puts "Set#{i} #{s.right} 0"
        end

        if s.is_a? FuzzyAssociativeMemory::Trapezoid
          datafile.puts "Set#{i} #{s.left} 0"
          datafile.puts "Set#{i} #{s.top_left} 1"
          datafile.puts "Set#{i} #{s.top_right} 1"
          datafile.puts "Set#{i} #{s.right} 0"
        end

        datafile.puts "\n\n"
      end
      datafile.close

      min = @sets[0].left
      max = @sets[0].right
      @sets.each do |s|
        min = s.left if s.left < min
        max = s.right if s.right > max
      end

      fn = "#{Dir.tmpdir}/plot of #{name}.svg"

      # set term dumb
      commands = %Q(
        set terminal svg size 1024,400
        set xlabel 'value'
        set ylabel 'membership'
        set xtics autofreq
        set ytics autofreq
        set output "#{fn}"
        set title "Fuzzy sets for #{name}"
        set mytics 4
        set mxtics 4
        set size ratio 0.25
        set grid mxtics xtics ytics

      )

      if opts[:logarithmic_x]
        commands += "set xr [[#{[min, 1].max}:#{max}]\nset logscale x\n"
      else
        commands += "set xr [#{min}:#{max}]\n"
      end

      #         plot "#{datafile.path}" using 2:3 notitle with linespoints lw 2

      plotarr=[]
      @sets.size.times do |i|
        plotarr[i] = %Q("#{datafile.path}" index #{i} using 2:3 notitle with linespoints pt 5 lw 2)
      end

      commands += "  plot " + plotarr.join(', ') + "\n"
      # puts commands

      IO.popen("gnuplot", "w") do |io|
        io.puts commands
      end
      #puts "Plot saved in #{fn}"

    rescue StandardError => e
      puts "Unable to run Gnuplot because #{e.message}"
    ensure
      datafile.close
      datafile.unlink
    end

    return fn if defined?(fn)
  end

  def [](n)
    @sets[n]
  end
end
