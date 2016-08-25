require 'net/http'
require 'json'
require 'time'
require 'open-uri'
require 'cgi'
require 'yaml'
require 'jira_helper'

def getAssigneeTable(jqlString, fieldname)
  json = JiraHelper.runQuery(jqlString)
  totalIssues = JSON.parse(json)["total"]
  num = 0
  assigneeHash = {}

  #go through the issues and count for each assignees
  while num < totalIssues do
    if JSON.parse(json)['issues'][num]!=nil
      assigneeField = JSON.parse(json)['issues'][num]['fields'][fieldname]
      if assigneeField == nil
        assignee = 'Unassigned'
      else
        assignee = assigneeField['displayName']
      end

      if assigneeHash.has_key?(assignee)
        assigneeHash[assignee] = assigneeHash[assignee] + 1
      else
        assigneeHash[assignee] = 1
      end
    end
    num = num + 1
  end

  return assigneeHash, totalIssues
end


def updateTableWidget(jqlString, fieldname, widgetId, title)

  #get the assignees from JIRA
  assigneeHash, totalIssues = getAssigneeTable(jqlString, fieldname)

  assignees = assigneeHash.keys
  numAssigned = assignees.length

  hrows = [
      {
          cols: [{value: title},
              {value: 'Total Issues'},
              {value: title},
              {value: 'Total Issues'}
          ]
      }
  ]

  count = 0
  rows = [{}]
  while count < numAssigned-1 do
    rows[count] = { cols: [ {value: assignees[count]}, {value: assigneeHash[assignees[count]]}, {value: assignees[count+1]}, {value: assigneeHash[assignees[count+1]]} ]}
    count = count + 2
  end

  if not assigneeHash.has_key?('Unassigned')
    totIssuesMsg = "Total Issues: #{totalIssues}, Unassigned: 0"
  else
    totIssuesMsg = "Total Issues: #{totalIssues}, Unassigned: #{assigneeHash['Unassigned']}"
  end

  Dashing.send_event(widgetId, {moreinfo: totIssuesMsg, hrows: hrows, rows: rows } )
  Rails.application.config.GLOBAL_CACHE[widgetId]["urlLink"]="https://coupadev.atlassian.net/issues/?jql="+jqlString
  Rails.application.config.GLOBAL_CACHE[widgetId]["hrows"]=hrows
  Rails.application.config.GLOBAL_CACHE[widgetId]["rows"]=rows
  Rails.application.config.GLOBAL_CACHE[widgetId]["updated"]="Last updated at "+Time.current.strftime("%H:%M") 
  Rails.application.config.GLOBAL_CACHE[widgetId]["jql"]=jqlString
end

# update tables every 20s
Dashing.scheduler.every '34m', :first_in => 10, allow_overlapping: false do

  if Rails.application.config.all_widgets
    Rails.application.config.all_widgets.each do |c|
      if c.widget_typeid == 4
          updateTableWidget(c.jql, c.filterby, c.id, c.title)
      end
    end
  end

end






