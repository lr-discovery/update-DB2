#!/usr/bin/env ruby
# encoding: utf-8
require_relative 'functions.rb'
require_relative 'work-tables-sql.rb'

puts 'hello'
opendb2()
def test
	sql = <<eos
	SELECT title_no from SYST.T_REG_TITLE
	fetch first 100 rows only;
eos
data = $db2.execute(sql)
  $db2.commit 
  data.each do |value|
	puts value
  end
end

test()
closedb2()
structure = getstubjson("DT160760")
puts structure
