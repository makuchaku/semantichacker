#!/usr/bin/env ruby

require "pp"
require "semantic_hacker"
require "db/migration_01"

if not ARGV[0]
  puts "To run test cases..."
  puts "\truby test.rb 'http://makuchaku.in'"
  exit
end

sh = SemanticHacker.new("YOUR_API_KEY", :uri, ARGV[0])

puts "Signatures"
sh.get_signatures.each do |s|
  puts "\t=> " + "[#{s[:weight]}] " + SemanticSignature.find(s[:index]).category
end

puts "Concepts"
sh.get_concepts.each do |s|
  puts "\t=> " + "[#{s[:weight]}] " + s[:label]
end


puts "Categories"
sh.get_categories.each do |s|
  puts "\t=> " + "[#{s[:weight]}] " + s[:label]
end


