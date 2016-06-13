class ChangeAvatarToPolimorphic < ActiveRecord::Migration
  def up
    add_reference :avatars, :avatarable, polymorphic: true, index: true
    remove_reference :avatars, :client, null: false, index: true
  end

  def down
    remove_reference :avatars, :avatarable, polymorphic: true, index: true
    add_reference :avatars, :client, null: false, index: true
  end
end
