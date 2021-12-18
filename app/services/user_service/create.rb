class UserService::Create < Service
  attribute :user, User

  def call
    user.transaction(requires_new: true) do
      fail_with_error(:invalid_user, user) unless user.save
    end

    user
  end
end
