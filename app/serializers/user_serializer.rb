class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :login
  def id
    object.id.to_s
  end
  # def friends
  #   object.friend_ids.map do |id|
  #     Rails.application.routes.url_helpers.person_path(id)
  #   end
  # end
end
