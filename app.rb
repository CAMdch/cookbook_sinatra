require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"

require "csv"
require_relative "recipe"
require_relative "cookbook"

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

get '/' do
  cookbook = Cookbook.new("recipes.csv")
  @recipes = cookbook.all
  erb :index
end

get '/add_a_recipe' do
  erb :add_recipe
end

post '/create' do
  cookbook = Cookbook.new("recipes.csv")
  recipe = Recipe.new(params[:name], params[:description], params[:star])
  cookbook.add_recipe(recipe)
  redirect '/'
end

get '/recipes/:index' do
  cookbook = Cookbook.new("recipes.csv")
  cookbook.remove_recipe(params[:index].to_i)
  redirect '/'
end
