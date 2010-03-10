#!/usr/bin/env ruby

require "pp"
require "semantic_hacker"
require "db/migration_01"

if not ARGV[0]
  puts "To run test cases..."
  puts "\truby test.rb 'http://makuchaku.in'"
  exit
end

sh = SemanticHacker.new("3ucknpc", :uri, ARGV[0])

puts "Signatures"
sh.get_signatures.each do |s|
  puts "\t=> " + SemanticSignature.find(s[:index]).category
end

puts "Concepts"
sh.get_concepts.each do |s|
  puts "\t=> " + s[:label]
end


puts "Categories"
sh.get_categories.each do |s|
  puts "\t=> " + s[:label]
end


