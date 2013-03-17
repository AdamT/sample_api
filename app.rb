require 'sinatra'
require 'json'
require 'mongoid'
require './models/post'
require './models/user'
require './models/comment'

Mongoid.load!("config/mongoid.yml")


get "/" do
  index_response
end

get "/index.json" do
  index_response
end

get "/seed" do
  User.create(full_name: "John Smith",
              email: "a@b.c",
              url: "http://www.google.com")

  redirect "/"
end

get "/clean" do
  Comment.delete_all
  Post.delete_all
  User.delete_all
  
  redirect "/"
end

get "/help" do
  # TODO
  # load help page
end

def index_response
  content_type :json
  User.all.to_json
end
