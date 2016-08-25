class AddPubToDashboard < ActiveRecord::Migration
  def change
    add_column :dashboards, :pub, :boolean
  end
end
