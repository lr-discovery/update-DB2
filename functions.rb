require 'oci8'
require 'rdbi-driver-odbc' 
require 'net/ssh'
require 'json'
require_relative 'db-connection'

## The function below will execute a command on the remote SSH server and then capture all responses.
def ssh_exec!(ssh, command)
  stdout_data = ""
  stderr_data = ""
  exit_code = nil
  exit_signal = nil
  ssh.open_channel do |channel|
    channel.exec(command) do |ch, success|
      unless success
        abort "FAILED: couldn't execute command (ssh.channel.exec)"
      end
      channel.on_data do |ch,data|
        stdout_data+=data
      end

      channel.on_extended_data do |ch,type,data|
        stderr_data+=data
      end

      channel.on_request("exit-status") do |ch,data|
        exit_code = data.read_long
      end

      channel.on_request("exit-signal") do |ch, data|
        exit_signal = data.read_long
      end
    end
  end
  ssh.loop
  [stdout_data, stderr_data, exit_code, exit_signal]
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