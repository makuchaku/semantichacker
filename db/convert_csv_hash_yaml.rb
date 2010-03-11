#!/usr/bin/env ruby

require "rubygems"
require "fastercsv"

csv = FasterCSV::parse(File.open(File.join(File.dirname(__FILE__), 'signatures.csv')).read)
yaml = {}
csv.each do |row|
  yaml[row[0]] = row[1]
end
File.open(File.join(File.dirname(__FILE__), 'signatures.yml'), "w").write(yaml.to_yaml)
