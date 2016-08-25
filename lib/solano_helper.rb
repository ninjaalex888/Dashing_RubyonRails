require 'eat'
require 'nokogiri'
require 'yaml'

class SolanoHelper

  def self.getJobStatus(jobname)

    #fetch the job file
    url = 'https://ci.solanolabs.com/cc/7d338a7ea1e79650a2464817e267ab6cbf5d6478/cctray.xml'
    response = eat(url, :openssl_verify_mode => 'none')
    xml = Nokogiri::XML(response)

    #get the build status
    lastBuildStatus = xml.css("Project[name='" + jobname + "']")[0]['lastBuildStatus']
    activity = xml.css("Project[name='" + jobname + "']")[0]['activity']

    status = {"activity" => activity, "lastBuildStatus" => lastBuildStatus}
  end

end