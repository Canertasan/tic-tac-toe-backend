class UserForm < FormObject
  form_for :user, params: [:name, :winning_count]
end
