#!/usr/bin/env ruby

require "semantic_hacker"

if not ARGV[0]
  puts "To run test cases..."
  puts "\truby test.rb 'http://makuchaku.in'"
  ARGV[0] = "http://makuchaku.in"
end

sh = SemanticHacker.new("YOUR_API_KEY").query_for(:uri, ARGV[0])

puts "Signatures"
sh.get_signatures.each do |s|
  puts "\t=> " + "[#{s[:weight]}] " + s[:label]
end

puts "Concepts"
sh.get_concepts.each do |s|
  puts "\t=> " + "[#{s[:weight]}] " + s[:label]
end


puts "Categories"
sh.get_categories.each do |s|
  puts "\t=> " + "[#{s[:weight]}] " + s[:label]
end


