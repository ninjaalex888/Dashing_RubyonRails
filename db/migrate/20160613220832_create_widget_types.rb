class CreateWidgetTypes < ActiveRecord::Migration

  def self.up

    create_table :widget_types do |t|
    	t.column :widget_type, :text
      t.column :widget_type_html, :string, :limit => 32
      #t.column :widget_fields, :array
   	end

   	
  end

  def self.down
  	drop_table :widget_types
  end


end
