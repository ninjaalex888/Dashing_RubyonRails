class CreateWidgets < ActiveRecord::Migration

  def self.up
      create_table :widgets do |t|
         t.column :title, :string, :limit => 32, :null => false
         t.column :moreinfo, :text
         t.column :jql, :text
         t.column :releaseversion, :string
         t.column :releasebranch, :string
         t.column :datatext, :text
         t.column :timelinedata, :text
         t.column :dateend, :text
         t.column :jobname, :text
         t.column :filterby, :text
         t.column :dashboard_id, :integer
         t.column :widget_typeid, :integer
         t.column :widget_templateid, :integer
      end

   end

   def self.down
      drop_table :widgets

   end

end
