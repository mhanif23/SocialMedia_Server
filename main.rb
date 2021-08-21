require 'sinatra'
require 'sinatra/json'
require 'sinatra/cross_origin'
require 'json'
require_relative './controllers/userController'
require_relative './controllers/postController'
require_relative './controllers/commentController'
require_relative './controllers/hastagController'

configure do
  enable :cross_origin
end

before do
  content_type :json
  response.headers['Access-Control-Allow-Origin'] = '*'
end

get '/trending_hastags' do
  controller = HastagController.new
  response = controller.find_trending()
  status response[:status]
  response.to_json
end

get '/hastag/:hastag' do
  controller = HastagController.new
  response = controller.find_post_by_id(params)
  status response[:status]
  response.to_json
end

get '/user/:username' do
  controller = UserController.new
  response = controller.find_user(params)
  status response[:status]
  response.to_json
end

post '/user/' do
  request_payload = JSON.parse request.body.read
  controller = UserController.new
  response = controller.create(request_payload)
  status response[:status]
  response.to_json
end

post '/user/bio' do
  request_payload = JSON.parse request.body.read
  controller = UserController.new
  response = controller.update_bio(request_payload)
  status response[:status]
  response.to_json
end

post '/post' do
  controller = PostController.new
  response = controller.create(params)
  status response[:status]
  response.to_json
end

post '/comment' do
  controller = CommentController.new
  response = controller.create(params)
  status response[:status]
  response.to_json
end

options "*" do
  response.headers["Allow"] = "GET, PUT, POST, DELETE, OPTIONS"
  response.headers["Access-Control-Allow-Origin"] = "*"
  200
end