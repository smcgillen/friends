require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'pg'


get '/' do
  erb :home
end


get '/newfriends' do

  erb :newfriends
end


post '/friends' do

  query = "INSERT INTO friends (name, age, gender, image_url, social_url) VALUES
  ('#{params[:nicname]}', '#{params[:age]}', '#{params[:gender]}', '#{params[:image_url]}', '#{params[:social_url]}')"
  conn = PG.connect(:dbname => 'friendslab', :host => 'localhost')
  conn.exec(query)
  conn.close

  redirect '/friends'

end


get '/friends' do

  query = "SELECT * FROM friends"
  conn = PG.connect(:dbname => 'friendslab', :host => 'localhost')
  @rows = conn.exec(query)
  conn.close

  erb :friends

end


