require 'sinatra'
require "sinatra/namespace"
require 'json'
require 'mongoid'

require './models/post'
require './models/user'
require './models/comment'

Mongoid.load!("config/mongoid.yml")

namespace "/v1" do
  get "/" do
    index_response
  end

  get "/blog" do
    "hi"
  end
end

get "/index.json" do
  index_response
end

# show all posts
get "/posts" do
end

# create a post
post "/posts/create" do
end

# delete a post
delete "/posts/:post_id/delete" do
end

# show a post
get "/posts/:post_id" do
end

# comment on post
post "/posts/:post_id/comments/create" do
end

# show post comment
get "/posts/:post_id/comments/:comment_id" do
end

# show all users
get "/users" do
end

# show user
get "/users/:id" do
end

# create user
post "/users/create" do
end

# show user posts
get "/users/:user_id/posts" do
end

# show user comments
get "/users/:user_id/comments" do
end


# quick seed
get "/seed" do
  User.create(full_name: "John Smith",
              email: "a@b.c",
              url: "http://www.google.com")

  redirect "/"
end

# quick clean
get "/clean" do
  Comment.delete_all
  Post.delete_all
  User.delete_all
  
  redirect "/"
end

# show help page
get "/help" do
  # TODO
  # load help page
end

options "/" do
end

def index_response
  content_type :json
  User.all.to_json
end
