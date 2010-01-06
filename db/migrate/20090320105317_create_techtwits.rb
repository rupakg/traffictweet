class CreateTechtwits < ActiveRecord::Migration
  def self.up
    create_table :techtwits do |t|
       t.integer :id
      t.string :twitter_id
      t.timestamps
    end
  end

  def self.down
    drop_table :techtwits
  end
end
