require 'sinatra'
require 'sinatra/json'
require 'json'
require_relative './controllers/userController'

before do
  content_type :json
end

get '/user/:username' do
  controller = UserController.new
  response = controller.find_user(params)
  status response[:status]
  response.to_json
end



# get '/users' do
#   status 200
#   json(
#     {
#       status: 200,
#       message: 'Success!',
#       data: {}
#     }
#   )
# end

# post '/test' do
#   request_payload = JSON.parse request.body.read
#   puts request_payload
#   status 200
#   json(
#     {
#       status: 200,
#       message: 'Success!',
#       data: request_payload
#     }
#   )
# end

# post '/file' do
#   tmpfile = params[:file]
#   puts tmpfile
#   status 200
#   json(
#     {
#       status: 200,
#       message: 'Success!',
#       data: tmpfile
#     }
#   )
# end
