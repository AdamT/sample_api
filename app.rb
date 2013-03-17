require 'sinatra'
require "sinatra/namespace"
require 'json'
require 'mongoid'
require 'pry'

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

namespace "/api/0.0.1" do

  # show all posts
  get "/posts" do
    Post.all.to_json
  end

  # create a post
  post "/posts/create" do
    Post.create(title: params[:title], 
                author: params[:author], 
                content: params[:content])
  end

  # delete a post
  delete "/posts/:post_id/delete" do
    post = Post.find(params[:post_id])
    post.delete
  end

  # show a post
  get "/posts/:post_id" do
    post = Post.find(params[:post_id])
    post.to_json
  end

  # comment on post
  post "/posts/:post_id/comments/create" do
    post = Post.find(params[:post_id])
    post.comments.create(author: params[:author],
                         content: params[:content])
  end

  # show post comment
  get "/posts/:post_id/comments/:comment_id" do
    post = Post.find(params[:post_id])
    comment = Post.comments.find(params[:comment_id])
    comment.to_json
  end

  # show post comments
  get "/posts/:post_id/comments" do
    post = Post.find(params[:post_id])
    post.comments.to_json
  end

  # show all comments
  get "/comments" do
    Comment.all.to_json
  end

  # show all users
  get "/users" do
    User.all.to_json
  end

  # show user
  get "/users/:user_id" do
    user = User.find(params[:user_id])
    user.to_json
  end

  # create user
  post "/users/create" do
    User.create(full_name: params[:full_name],
                email: params[:email],
                url: params[:url])
  end

  # show user posts
  get "/users/:user_id/posts" do
    user = User.find(params[:user_id])
    user.posts.to_json
  end

  # show user comments
  get "/users/:user_id/comments" do
    user = User.find(params[:user_id])
    user.comments.to_json
  end

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
