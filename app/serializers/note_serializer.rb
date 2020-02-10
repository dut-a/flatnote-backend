class NoteSerializer < ActiveModel::Serializer
  attributes :title, :notes, :tags, :created_at, :updated_at, :user
end
