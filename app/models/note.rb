class Note < ApplicationRecord
  # Associations
  belongs_to :user
  accepts_nested_attributes_for :user, allow_destroy: true

  # Validations
  validates :title, :notes, {:presence => true}
  validates :tags, {:presence => true, :allow_blank => true}

end
