#!/bin/env ruby
# encoding: utf-8


#Environment parameters
$db2Env = ENV['DB2ENV'] || 'CAPS'


def opendb2()
puts 'Connecting to DB2';
$db2 = RDBI.connect :ODBC, :db => $db2Env
end

def closedb2()
$db2.disconnect
end