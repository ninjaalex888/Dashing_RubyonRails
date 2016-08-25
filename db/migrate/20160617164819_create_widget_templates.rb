class CreateWidgetTemplates < ActiveRecord::Migration
  
  def self.up

    create_table :widget_templates do |t|

      t.column :title, :string, :limit => 32, :null => false
      t.column :moreinfo, :text
      t.column :jql, :text
      t.column :datatext, :text
      t.column :timelinedata, :text
      t.column :dateend, :text
      t.column :jobname, :text
      t.column :filterby, :text
      t.column :widget_type, :string

   	end

   


  end

  def self.down
  	drop_table :widget_templates
  end

end
