require 'jira_issuecount'

class WidgetController < ApplicationController
	layout 'configLayout'
  
	def list
		@widgets = Widget.all
	end

	def show
		@widget = Widget.find(params[:id])
	end

	def new
		@widget = Widget.new
		@dashboards = Dashboard.all
		@widget_types = WidgetTypes.all
	end

	def widget_params
		params.require(:widgets).permit(:title, :moreinfo, :jql, :releaseversion, :datatext, :timelinedata, :dateend, :jobname, :filterby, :dashboard_id, :widget_typeid, :widget_templateid)
	end

	def create
		@widget = Widget.new(widget_params)

		if @widget.save
			redirect_to :controller => 'dashboard', :action => 'list'
		else
			@dashboards = Dashboard.all
			render :action => 'new'
		end

		Rails.application.config.all_widgets = Widget.all
	end

	def edit
		@widget = Widget.find(params[:id])
		@dashboards = Dashboard.all
		@widget_types = WidgetTypes.all
		Rails.application.config.all_widgets = Widget.all
	end

	def widget_param
		params.require(:widget).permit(:title, :moreinfo, :jql, :releaseversion, :datatext, :timelinedata, :dateend, :jobname, :filterby, :dashboard_id, :widget_typeid, :widget_templateid)
	end

	def update
		@widget = Widget.find(params[:id])
		if @widget.update_attributes(widget_param)
			redirect_to :action => 'show', :id => @widget
		else
			@dashboards = Dashboard.all
			render :action => 'edit'
		end
		Rails.application.config.all_widgets = Widget.all
	end

	def delete
		Widget.find(params[:id]).destroy
		redirect_to :controller => 'dashboard', :action => 'list'
	end

	def show_dashboards
		@dashboard = Dashboard.find(params[:id])
	end

end
