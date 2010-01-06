class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.text :message
      t.timestamps
    end
  end

  def self.down
    drop_table :posts
  end
end
