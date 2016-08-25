require 'net/http'
require 'yaml'
require 'uri'
require './lib/assets/testrail.rb'
require 'json'
require 'nokogiri'



class TestrailHelper

  def self.getMilestone(milestone_id)
    #load config
    if File.exist?('./config/initializers/config_userpass.yml')
      config_data = YAML.load_file('./config/initializers/config_userpass.yml')
    end

    url = 'https://coupa.testrail.com'

    username = ENV['TESTRAIL_USER'] || config_data['testrails']['user']
    password = ENV['TESTRAIL_PASSWORD'] || config_data['testrails']['pass']

    #fetch the job
    client = TestRail::APIClient.new('https://coupa.testrail.com')
    client.user = username
    client.password = password
    plans = client.send_get("get_plans/1&milestone_id=#{milestone_id}")
    runs = client.send_get("get_runs/1&milestone_id=#{milestone_id}")

    #extract the count
    passed = 0
    blocked = 0
    untested = 0
    retest = 0
    failed = 0
    notplanned = 0
    regressionfail = 0
    plan_count = plans.size + runs.size

    plans.each do |plan|
      passed += plan["passed_count"].to_i
      blocked += plan["blocked_count"].to_i
      untested += plan["untested_count"].to_i
      retest += plan["retest_count"].to_i
      failed += plan["failed_count"].to_i
      notplanned += plan["custom_status1_count"].to_i
      regressionfail += plan["custom_status2_count"].to_i
    end

    runs.each do |run|
      passed += run["passed_count"].to_i
      blocked += run["blocked_count"].to_i
      untested += run["untested_count"].to_i
      retest += run["retest_count"].to_i
      failed += run["failed_count"].to_i
      notplanned += run["custom_status1_count"].to_i
      regressionfail += run["custom_status2_count"].to_i
    end


    #return the values
    ret = Hash.new
    ret['passed'] = passed
    ret['blocked'] = blocked
    ret['untested'] = untested
    ret['retest'] = retest
    ret['failed'] = failed
    ret['notplanned'] = notplanned
    ret['regressionfail'] = regressionfail

    return ret
  end
end

