class RenameDescriptionFromImages < ActiveRecord::Migration
  def up
	rename_column :images, :description, :title
  end

  def down
  end
end
