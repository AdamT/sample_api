require "mongoid"


class Comment
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :post

  field :author, type: String
  field :content, type: String
end
