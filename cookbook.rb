require "csv"
require_relative "recipe"

class Cookbook
  attr_reader :recipes

  def initialize(csv_file_path)
    @recipes = []
    @csv_file_path = csv_file_path
    CSV.foreach(csv_file_path) { |recipe| @recipes.push(Recipe.new(recipe[0], recipe[1], recipe[2], recipe[3])) }
  end

  def all
    @recipes
  end

  def add_recipe(recipe)
    @recipes.push(recipe)
    CSV.open(@csv_file_path, "ab") { |csv| csv << [recipe.name, recipe.description, recipe.star, recipe.done] }
  end

  def mark_as_done(index)
    @recipes[index].mark_as_done!
    CSV.open(@csv_file_path, "wb") do |csv|
      @recipes.each { |recipe| csv << [recipe.name, recipe.description, recipe.star, recipe.done] }
    end
  end

  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index)
    CSV.open(@csv_file_path, "wb") do |csv|
      @recipes.each { |recipe| csv << [recipe.name, recipe.description, recipe.star, recipe.done] }
    end
  end
end
