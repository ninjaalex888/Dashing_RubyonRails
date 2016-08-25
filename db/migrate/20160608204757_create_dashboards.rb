class CreateDashboards < ActiveRecord::Migration

   def self.up
      
      create_table :dashboards do |t|
         t.column :release, :string
         t.column :layoutDash, :text
         t.column :user_id, :integer
         t.column :pub, :boolean
      end

      #Dashboard.create :release => "R15.5"

      #Dashboard.create :release => "R15.4"
      # Subject.create :name => "Mathematics"
      # Subject.create :name => "Chemistry"
      # Subject.create :name => "Psychology"
      # Subject.create :name => "Geography"
   end

   def self.down
      drop_table :dashboards
   end

end
