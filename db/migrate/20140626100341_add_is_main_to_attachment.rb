class AddIsMainToAttachment < ActiveRecord::Migration
  def change
    add_column :attachments, :is_main, :boolean
  end
end
