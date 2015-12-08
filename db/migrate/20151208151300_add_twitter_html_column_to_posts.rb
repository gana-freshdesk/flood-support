class AddTwitterHtmlColumnToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :twitter_html, :text
  end
end
