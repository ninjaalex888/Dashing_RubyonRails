 # This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


	WidgetTemplates.create(:title => "Issues Open", :jql => 'category = CDC AND issuetype in (Bug, Story) AND (fixVersion = v{VERSION} OR "Target Release" = v{VERSION} AND (fixVersion is EMPTY OR fixVersion != v{VERSION}) {BRANCH} AND ("Target Release" is EMPTY OR "Target Release" != v{VERSION}) OR affectedVersion = v{VERSION} AND "Target Release" is EMPTY AND issuetype in (standardIssueTypes())) AND (resolution = Fixed OR resolution is EMPTY) AND status = Open ORDER BY Rank ASC', :widget_type => "Number")
   	WidgetTemplates.create(:title => "Issues Closed", :jql => 'category = CDC AND issuetype in (Bug, Story) AND (fixVersion = v{VERSION} OR "Target Release" = v{VERSION} AND (fixVersion is EMPTY OR fixVersion != v{VERSION}) {BRANCH} AND ("Target Release" is EMPTY OR "Target Release" != v{VERSION}) OR affectedVersion = v{VERSION} AND "Target Release" is EMPTY AND issuetype in (standardIssueTypes())) AND (resolution = Fixed OR resolution is EMPTY) AND status = Closed ORDER BY Rank ASC', :widget_type => "Number")
    WidgetTemplates.create(:title => "Issues In Progress", :jql => 'category = CDC AND issuetype in (Bug, Story) AND (fixVersion = v{VERSION} OR "Target Release" = v{VERSION} AND (fixVersion is EMPTY OR fixVersion != v{VERSION}) {BRANCH} AND ("Target Release" is EMPTY OR "Target Release" != v{VERSION}) OR affectedVersion = v{VERSION} AND "Target Release" is EMPTY AND issuetype in (standardIssueTypes())) AND (resolution = Fixed OR resolution is EMPTY) AND status = "In Progress" ORDER BY Rank ASC', :widget_type => "Number")
    WidgetTemplates.create(:title => "Issues Resolved", :jql => 'category = CDC AND issuetype in (Bug, Story) AND (fixVersion = v{VERSION} OR "Target Release" = v{VERSION} AND (fixVersion is EMPTY OR fixVersion != v{VERSION}) {BRANCH} AND ("Target Release" is EMPTY OR "Target Release" != v{VERSION}) OR affectedVersion = v{VERSION} AND "Target Release" is EMPTY AND issuetype in (standardIssueTypes())) AND (resolution = Fixed OR resolution is EMPTY) AND status = Resolved ORDER BY Rank ASC', :widget_type => "Number")

    WidgetTemplates.create(:title => "Assignee Table", :jql => 'category = CDC AND issuetype in (Bug, Story) AND (fixVersion = v{VERSION} OR "Target Release" = v{VERSION} AND (fixVersion is EMPTY OR fixVersion != v{VERSION}) {BRANCH} AND ("Target Release" is EMPTY OR "Target Release" != v{VERSION}) OR affectedVersion = v{VERSION} AND "Target Release" is EMPTY AND issuetype in (standardIssueTypes())) AND (resolution = Fixed or resolution is EMPTY) AND status in (Open, "In Progress") ORDER BY Rank ASC', :filterby => "assignee", :widget_type => "AssigneeTable")
    WidgetTemplates.create(:title => "QE Assignee Table", :jql => 'category = CDC AND issuetype in (Bug, Story) AND (fixVersion = v{VERSION} OR "Target Release" = v{VERSION} AND (fixVersion is EMPTY OR fixVersion != v{VERSION})  {BRANCH} AND ("Target Release" is EMPTY OR "Target Release" != v{VERSION}) OR affectedVersion = v{VERSION} AND "Target Release" is EMPTY AND issuetype in (standardIssueTypes())) AND (resolution = Fixed or resolution is EMPTY) AND status in (Open, "In Progress") ORDER BY Rank ASC', :filterby => "customfield_13100", :widget_type => "AssigneeTable")

    WidgetTemplates.create(:title => "Release Sprint", :timelinedata => '{"events":[{"name":"Code Freeze","date":"Jul 1, 2016","background": "lightblue"},{"name":"System Test Start","date": "Jul 18, 2016","background": "white"},{"name":"System Test Complete","date": "Aug 12, 2016", "background": "lightblue"} ,{"name":"Hardening Sprint Start","date": "Aug 15, 2016","background": "white"}]}', :widget_type => "Timeline")

    WidgetTemplates.create(:title => "Sprint Progress", :datatext => 'Sprint 13', :moreinfo => "Jun 20 - Jul 1", :widget_type => "Text")

    WidgetTemplates.create(:title => "Sprint Burndown", :jql => 'sprint in openSprints() AND labels in (tech_platform_team)', :widget_type => "GoogleLine")

    WidgetTemplates.create(:title => "Percentage of Work Done", :jql => 'sprint in openSprints() AND labels in (tech_platform_team)', :widget_type => "Meter")

    WidgetTemplates.create(:title => "Teamcity Builds", :jobname => 'master', :widget_type => "BuildStatusTeamcity")
    WidgetTemplates.create(:title => "Jenkins Dev Master", :jobname => 'dev-master', :widget_type => "BuildStatusJenkins")
    WidgetTemplates.create(:title => "Jenkins API Master", :jobname => 'api_test_master', :widget_type => "BuildStatusJenkins")

    WidgetTemplates.create(:title => "End of Sprint Countdown", :dateend => '1-July-2016 17:00:00', :widget_type => "Countdown")



    WidgetTypes.create(:widget_type => "Number", :widget_type_html => "number") 
   	WidgetTypes.create(:widget_type => "Timeline", :widget_type_html => "timeline")
    WidgetTypes.create(:widget_type => "Text", :widget_type_html => "text")
    WidgetTypes.create(:widget_type => "Assignee Table", :widget_type_html => "assigneetable")
    WidgetTypes.create(:widget_type => "Components Table", :widget_type_html => "componentstable")
    WidgetTypes.create(:widget_type => "Line Chart", :widget_type_html => "linechart")
    WidgetTypes.create(:widget_type => "Meter", :widget_type_html => "meter")
    WidgetTypes.create(:widget_type => "Countdown", :widget_type_html => "countdown")
    WidgetTypes.create(:widget_type => "Build Status Teamcity", :widget_type_html => "buildstatusteamcity")
    WidgetTypes.create(:widget_type => "Build Status Solano", :widget_type_html => "buildstatussolano")
    WidgetTypes.create(:widget_type => "Build Status Jenkins", :widget_type_html => "buildstatusjenkins")
    WidgetTypes.create(:widget_type => "Github Status", :widget_type_html => "githubstatus")
    WidgetTypes.create(:widget_type => "Jenkins Perf Response Codes", :widget_type_html => "columnchart")
    WidgetTypes.create(:widget_type => "Jenkins Avg Response Time", :widget_type_html => "jenkinsnumber")
    WidgetTypes.create(:widget_type => "Testrail Test Status Chart", :widget_type_html => "piechart")

    
    dashboardR16 = Dashboard.create(:pub=>true, :release => "R16 Release Dash", :layoutDash => '<script type=\'text/javascript\'>
 $(function() {
   Dashing.gridsterLayout(\'[{"col":1,"row":1,"size_x":1,"size_y":1},{"col":1,"row":2,"size_x":1,"size_y":2},{"col":3,"row":1,"size_x":1,"size_y":1},{"col":3,"row":2,"size_x":1,"size_y":1},{"col":4,"row":1,"size_x":1,"size_y":1},{"col":4,"row":2,"size_x":1,"size_y":1},{"col":2,"row":1,"size_x":1,"size_y":1},{"col":2,"row":2,"size_x":1,"size_y":1},{"col":2,"row":3,"size_x":1,"size_y":1},{"col":3,"row":3,"size_x":2,"size_y":1}]\')
 });
 </script>')
    Widget.create(:title => "R16", :datatext => "Release Dashboard", :moreinfo => "", :dashboard_id => dashboardR16.id, :widget_typeid => 3)
    Widget.create(:title=> "Timeline", :timelinedata=>'{"events":[{"name":"Code Freeze","date":"Jul 1, 2016","background": "lightblue"},{"name":"System Test Start","date": "Jul 18, 2016","background": "white"},{"name":"System Test Complete","date": "Aug 12, 2016", "background": "lightblue"} ,{"name":"Hardening Sprint Start","date": "Aug 15, 2016","background": "white"}]}',:dashboard_id => dashboardR16.id, :widget_typeid => 2)
    Widget.create(:title => "Issues Open", :jql => 'category = CDC AND issuetype in (Bug, Story) AND (fixVersion = v16.0.0 OR "Target Release" = v16.0.0 AND (fixVersion is EMPTY OR fixVersion != v16.0.0) AND ("Target Release" is EMPTY OR "Target Release" != v16.0.0) OR affectedVersion = v16.0.0 AND "Target Release" is EMPTY AND issuetype in (standardIssueTypes())) AND (resolution = Fixed OR resolution is EMPTY) AND status = Open ORDER BY Rank ASC', :dashboard_id => dashboardR16.id, :widget_typeid => 1)
    Widget.create(:title => "Issues Resolved", :jql => 'category = CDC AND issuetype in (Bug, Story) AND (fixVersion = v16.0.0 OR "Target Release" = v16.0.0 AND (fixVersion is EMPTY OR fixVersion != v16.0.0) AND ("Target Release" is EMPTY OR "Target Release" != v16.0.0) OR affectedVersion = v16.0.0 AND "Target Release" is EMPTY AND issuetype in (standardIssueTypes())) AND (resolution = Fixed OR resolution is EMPTY) AND status = Resolved ORDER BY Rank ASC', :dashboard_id => dashboardR16.id, :widget_typeid => 1)
    Widget.create(:title => "Issues In Progress", :jql => 'category = CDC AND issuetype in (Bug, Story) AND (fixVersion = v16.0.0 OR "Target Release" = v16.0.0 AND (fixVersion is EMPTY OR fixVersion != v16.0.0) AND ("Target Release" is EMPTY OR "Target Release" != v16.0.0) OR affectedVersion = v16.0.0 AND "Target Release" is EMPTY AND issuetype in (standardIssueTypes())) AND (resolution = Fixed OR resolution is EMPTY) AND status = "In Progress" ORDER BY Rank ASC', :dashboard_id => dashboardR16.id, :widget_typeid => 1)
    Widget.create(:title => "Issues Closed", :jql => 'category = CDC AND issuetype in (Bug, Story) AND (fixVersion = v16.0.0 OR "Target Release" = v16.0.0 AND (fixVersion is EMPTY OR fixVersion != v16.0.0) AND ("Target Release" is EMPTY OR "Target Release" != v16.0.0) OR affectedVersion = v16.0.0 AND "Target Release" is EMPTY AND issuetype in (standardIssueTypes())) AND (resolution = Fixed OR resolution is EMPTY) AND status = Closed ORDER BY Rank ASC', :dashboard_id => dashboardR16.id, :widget_typeid => 1)
    # Widget.create(:title => "Components Table", :jql=>'category = CDC AND issuetype in (Bug, Story) AND (fixVersion = v16.0.0 OR "Target Release" = v16.0.0 AND (fixVersion is EMPTY OR fixVersion != v16.0.0) OR "Target Branch" = master  AND ("Target Release" is EMPTY OR "Target Release" != v16.0.0) OR affectedVersion = v16.0.0 AND "Target Release" is EMPTY AND issuetype in (standardIssueTypes())) ORDER BY Rank ASC',:dashboard_id => dashboardR16.id, :widget_typeid => 5)
    Widget.create(:title=>"Teamcity Builds", :jobname=>'master',:dashboard_id => dashboardR16.id, :widget_typeid => 9)
    Widget.create(:title=>"Jenkins Dev-Master", :jobname=>'dev-master', :dashboard_id => dashboardR16.id, :widget_typeid => 11)
    Widget.create(:title=>"Jenkins API-Master", :jobname=>'api_test_master',:dashboard_id => dashboardR16.id, :widget_typeid => 11)
    Widget.create(:title=>"R16 Testrail", :jobname=>'41',:dashboard_id => dashboardR16.id, :widget_typeid => 15)



    dashboardSprint = Dashboard.create(:pub=>true, :release => "R16 Sprint")
    Widget.create(:title => "Sprint Progress", :datatext => "Sprint 13", :moreinfo => "Jun 20 - Jul 1", :dashboard_id => dashboardSprint.id, :widget_typeid => 3)
    Widget.create(:title => "Sprint Burndown", :jql=>'sprint in openSprints() AND labels in (tech_platform_team)',:dashboard_id => dashboardSprint.id, :widget_typeid => 6)
    Widget.create(:title => "Percentage of Work Done", :jql=>'sprint in openSprints() AND labels in (tech_platform_team)',:dashboard_id => dashboardSprint.id, :widget_typeid => 7)
    #Widget.create(:title => "Components Table", :jql=>'sprint in openSprints() AND labels in (tech_platform_team)',:dashboard_id => dashboardSprint.id, :widget_typeid => 5)
    Widget.create(:title => "Assignee Table", :jql => 'category = CDC AND issuetype in (Bug, Story) AND (fixVersion = v16.0.0 OR "Target Release" = v16.0.0 AND (fixVersion is EMPTY OR fixVersion != v16.0.0) AND ("Target Release" is EMPTY OR "Target Release" != v16.0.0) OR affectedVersion = v16.0.0 AND "Target Release" is EMPTY AND issuetype in (standardIssueTypes())) AND (resolution = Fixed OR resolution is EMPTY) AND status in (Open, "In Progress") ORDER BY Rank ASC', :filterby => "assignee", :dashboard_id => dashboardSprint.id, :widget_typeid => 4)
    Widget.create(:title => "QE Assignee Table", :jql => 'category = CDC AND issuetype in (Bug, Story) AND (fixVersion = v16.0.0 OR "Target Release" = v16.0.0 AND (fixVersion is EMPTY OR fixVersion != v16.0.0) AND ("Target Release" is EMPTY OR "Target Release" != v16.0.0) OR affectedVersion = v16.0.0 AND "Target Release" is EMPTY AND issuetype in (standardIssueTypes())) AND (resolution = Fixed OR resolution is EMPTY) AND status in (Open, "In Progress") ORDER BY Rank ASC', :filterby => "customfield_13100", :dashboard_id => dashboardSprint.id, :widget_typeid => 4)
    Widget.create(:title=>"Teamcity Builds", :jobname=>'master',:dashboard_id => dashboardSprint.id, :widget_typeid => 9)
    Widget.create(:title=>"Jenkins Dev-Master", :jobname=>'dev-master', :dashboard_id => dashboardSprint.id, :widget_typeid => 11)
    Widget.create(:title=>"Jenkins API-Master", :jobname=>'api_test_master',:dashboard_id => dashboardSprint.id, :widget_typeid => 11)
    Widget.create(:title=>"End of Sprint Countdown", :dateend=>"29-July-2016 17:00:00",:dashboard_id => dashboardSprint.id, :widget_typeid => 8)

    dashboardPerformance = Dashboard.create(:pub=>true, :release => "Performance Dashboard", :layoutDash => '<script type=\'text/javascript\'>
 $(function() {
   Dashing.gridsterLayout(\'[{"col":1,"row":1,"size_x":1,"size_y":1},{"col":3,"row":1,"size_x":1,"size_y":1},{"col":3,"row":2,"size_x":1,"size_y":1},{"col":2,"row":1,"size_x":1,"size_y":1},{"col":2,"row":2,"size_x":1,"size_y":1},{"col":4,"row":1,"size_x":1,"size_y":1},{"col":4,"row":2,"size_x":1,"size_y":1}]\')
 });
 </script>')
    Widget.create(:title => "R16, R15, R14", :datatext => "Performance Dashboard", :moreinfo => "", :dashboard_id => dashboardPerformance.id, :widget_typeid => 3)
    Widget.create(:title=>"Response Codes", :jobname=>'api_perf_15',:dashboard_id => dashboardPerformance.id, :widget_typeid => 13)
    Widget.create(:title=>"Avg Resonse Time", :jobname=>'api_perf_15',:dashboard_id => dashboardPerformance.id, :widget_typeid => 14)
    Widget.create(:title=>"Response Codes", :jobname=>'api_perf_14',:dashboard_id => dashboardPerformance.id, :widget_typeid => 13)
    Widget.create(:title=>"Avg Resonse Time", :jobname=>'api_perf_14',:dashboard_id => dashboardPerformance.id, :widget_typeid => 14)
    Widget.create(:title=>"Response Codes", :jobname=>'api_perf_master',:dashboard_id => dashboardPerformance.id, :widget_typeid => 13)
    Widget.create(:title=>"Avg Resonse Time", :jobname=>'api_perf_master',:dashboard_id => dashboardPerformance.id, :widget_typeid => 14)
   


