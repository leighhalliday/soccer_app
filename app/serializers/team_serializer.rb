class TeamSerializer < ActiveModel::Serializer
  attributes :id,
    :name,
    :updated_at
  has_many :players
  belongs_to :league
end