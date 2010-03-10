#!/usr/bin/env ruby

require "pp"
require "semantic_hacker"

sh = SemanticHacker.new("YOUR_API_KEY", :uri, "http://microsoft.com")
pp sh.get_signatures
pp sh.api_call
pp sh.get_concepts
pp sh.get_categories

