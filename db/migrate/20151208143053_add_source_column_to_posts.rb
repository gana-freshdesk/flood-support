class AddSourceColumnToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :source, :integer
  end
end
