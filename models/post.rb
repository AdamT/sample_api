require 'mongoid'

class Post
  include Mongoid::Document
  include Mongoid::Timestamps

  has_many :comments

  field :title, type: String
  field :author, type: String
  field :content, type: String
end
