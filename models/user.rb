require 'mongoid'

class User
  include Mongoid::Document
  include Mongoid::Timestamps

  has_many :posts
  has_many :comments

  field :full_name, type: String
  field :email, type: String
  field :url, type: String
end
