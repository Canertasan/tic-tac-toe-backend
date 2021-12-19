class User < ApplicationRecord
  validates :name, uniqueness: { case_sensitive: true }, presence: true
  validates_format_of :name, with: /\A[a-zA-Z0-9_\-]+\z/
end
