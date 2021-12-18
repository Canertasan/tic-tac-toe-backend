class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :winning_count
end
