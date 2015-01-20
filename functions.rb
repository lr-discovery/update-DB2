require 'rubygems'
require 'net/http'
require 'oci8'
require 'rdbi-driver-odbc' 
require 'net/ssh'
require 'json'
require_relative 'db-connection'

#These are web service call passwords that can be set or default to ''
$http_auth_name = (ENV['HTTPAUTH_USERNAME'] || '')
$http_auth_password = (ENV['HTTPAUTH_PASSWORD'] || '')

#List of URLs to access its defaulted but then possible to export a different address so it points to the cloud instead
$STUBJSON = (ENV['http://localhost:4567'] || '')
$STUBJSON = 'http://localhost:4567/'
#This function gets the json object
def getstubjson(title_number)
  uri = URI.parse($STUBJSON)
  http = Net::HTTP.new(uri.host, uri.port)
  request = Net::HTTP::Get.new('/' + title_number)
  request.basic_auth $http_auth_name, $http_auth_password
  response = http.request(request)
  if (response.code != '200') then
    raise "Error in getting JSON for: " + title_number
  end
  return response.body
end


##takes in sql and replaces the DB prefix and returns the sql
def fixSQL(sql) 

	sql = sql.gsub(/fnd_dev/, 'FND_DEV')
	sql = sql.gsub(/stg_dev/, 'STG_DEV')
	sql = sql.gsub(/acs_dev/, 'ACS_DEV')
	sql = sql.gsub(/mtd_dev/, 'MTD_DEV')

	if ($oracleEnv == 'ci') then
		sql = sql.gsub(/FND_DEV/, 'FND_CI')
		sql = sql.gsub(/STG_DEV/, 'STG_CI')
		sql = sql.gsub(/ACS_DEV/, 'ACS_CI')
		sql = sql.gsub(/MTD_DEV/, 'MTD_CI')
		sql = sql.gsub(/fnd_dev/, 'FND_CI')
		sql = sql.gsub(/stg_dev/, 'STG_CI')
		sql = sql.gsub(/acs_dev/, 'ACS_CI')
		sql = sql.gsub(/mtd_dev/, 'MTD_CI')
	end
	
	return sql
	
end