require 'rubygems'
require 'json'

class ParserMethods
  def self.committer_email(payload) 
    parameter_name = "committer_email"
    parameter_value = payload['commits'][0]['committer']['email']
    WriteFile.send(:process_file, parameter_name, parameter_value)
  end

  def self.pusher_email(payload)
    parameter_name = "pusher_email"
    parameter_value = payload['pusher']['email']
    WriteFile.send(:process_file, parameter_name, parameter_value)
  end
end

class WriteFile
  def self.process_file(parameter_name, parameter_value)
    puts parameter_name
    puts parameter_value
    f = File.open('github_properties.txt', 'a')
    f.puts parameter_name+"="+parameter_value
    f.close
  end
end

def json_read
  file = File.read('payload.json')
  @payload = JSON.parse(file)
end

def args_processor
  ARGV.each do |arg|
    ParserMethods.send(arg.to_sym, @payload)
  end
end


json_read
args_processor

