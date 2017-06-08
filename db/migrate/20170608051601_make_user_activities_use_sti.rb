class MakeUserActivitiesUseSti < ActiveRecord::Migration[5.1]
  def up
    rename_column :user_activities, :action, :type
    update <<-SQL
      UPDATE user_activities SET type = 'BookmarkActivity'
    SQL
  end

  def down
    rename_column :user_activities, :type, :action
    update <<-SQL
      UPDATE user_activities SET action = 'bookmark'
    SQL
  end

  # def change
  # rename_column :user_activities, :action, :type
  # reversible do |dir|
  #   dir.up do
  #     update <<-SQL
  #       UPDATE user_activities SET type = 'BookmarkActivity'
  #     SQL
  #   end
  #   dir.down do
  #     update <<-SQL
  #       UPDATE user_activities SET action = 'bookmarks'
  #     SQL
  #   end
  # end
  # end
end
