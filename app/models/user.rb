class User < ApplicationRecord
  REGEX = /\A([^}{\]\[@\s,]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i.freeze

  validates :name, uniqueness: { case_sensitive: true }, presence: true, format: { with: REGEX }
end
