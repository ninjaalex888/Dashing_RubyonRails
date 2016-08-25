require 'net/http'
require 'json'
require 'yaml'
require 'uri'
require 'jira_helper'

class JenkinsHelper

  def self.getJobStatus(jobname)

    #load config
    if File.exist?('./config/initializers/config_userpass.yml')
      config_data = YAML.load_file('./config/initializers/config_userpass.yml')
    end

    url =  "https://coupadev.atlassian.net"
    username = ENV['JENKINS_USER'] || config_data['jenkins']['user']
    password = ENV['JENKINS_PASSWORD'] || config_data['jenkins']['pass']


    #get the job status
    uri = URI.parse("https://jenkins.coupadev.com/job/" + jobname + "/api/json")
    connection = ::Net::HTTP.new(uri.host, uri.port)
    connection.use_ssl = true
    connection.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(uri.request_uri)
    request.basic_auth username, password
    response = connection.request(request)

    case response
      when Net::HTTPSuccess
        json = JSON.parse(response.body)
        to_status(json['color'])
      else
        puts "Jenkins Unsuccessful API Retrieval"
        :red
    end
  end


  def self.to_status(color)
    colormap = {
        'blue'=>:green,
        'yellow'=>:red,
        'red'=>:red,
        'blue_anime'=>:green,
        'yellow_anime'=>:red,
        'red_anime'=>:red
    }
    colormap[color]
  end

  def self.get_jtl(jobname)

    if File.exist?('./config/initializers/config_userpass.yml')
      config_data = YAML.load_file('./config/initializers/config_userpass.yml')
    end

    url =  "https://coupadev.atlassian.net"
    username = ENV['JENKINS_USER'] || config_data['jenkins']['user']
    password = ENV['JENKINS_PASSWORD'] || config_data['jenkins']['pass']

    uri = URI.parse("https://jenkins.coupadev.com/job/" + jobname + "/lastSuccessfulBuild/artifact/perf_result.jtl")
    connection = ::Net::HTTP.new(uri.host, uri.port)
    connection.use_ssl = true
    connection.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(uri.request_uri)
    request.basic_auth username, password
    response = connection.request(request)
    return response.body
  end

end