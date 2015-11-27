class PlayerSerializer < ActiveModel::Serializer
  attributes :id,
    :name,
    :position,
    :nickname,
    :jersey_number,
    :nationality,
    :updated_at
end