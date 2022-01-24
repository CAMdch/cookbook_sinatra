class Recipe
  attr_reader :name, :description, :star
  attr_accessor :done

  def initialize(name, description, star, done = "false")
    @name = name
    @description = description
    @star = star
    @done = done
  end

  def done?
    return true   if @done == "true"
    return false  if @done == "false"
  end

  def mark_as_done!
    @done = "true"
  end
end
