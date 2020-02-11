class NoteSerializer < ActiveModel::Serializer
  attributes :id, :title, :details, :tags, :user, :created_at, :updated_at

  def user
    return {
      id: self.object.user.id,
      username: self.object.user.username,
      bio: self.object.user.bio,
      avatar: self.object.user.avatar
    }
  end

end
