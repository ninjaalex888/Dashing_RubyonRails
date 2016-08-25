require 'net/http'
require 'json'
require 'yaml'
require 'uri'

class TeamCityHelper

    def self.getJobStatus(jobname)

        #load config
        if File.exist?('./config/initializers/config_userpass.yml')
          config_data = YAML.load_file('./config/initializers/config_userpass.yml')
        end

        url =  "https://teamcity.coupadev.com/"
        username = ENV['TEAMCITY_USER'] || config_data['teamcity']['user']
        password = ENV['TEAMCITY_PASSWORD'] || config_data['teamcity']['pass']

        #fetch the job status
        uri = URI.parse(url + "httpAuth/app/rest/builds/buildType:"+jobname)
        connection = ::Net::HTTP.new(uri.host, uri.port)
        connection.use_ssl = true
        connection.verify_mode = OpenSSL::SSL::VERIFY_NONE
        request = Net::HTTP::Get.new(uri.request_uri)#, #{'Accept'=>'*'})
        request.basic_auth username, password
        response = connection.request(request)

    #parse the job status
    xml = Nokogiri::XML(response.body)
    
    status = xml.css("build[buildTypeId='" + jobname + "']")[0]['status']
    


    rescue Timeout::Error => e
        puts "timeout detected from helper"
        puts "***e***"
        puts e
        puts "***e***"
    end
end
