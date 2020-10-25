class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    all.limit(5)
    # The implicit receiver of any method call is self 
    # all is an AR method 
    # Boat.first_five.pluck(:name)
    # Boat.first_five 
  end


  def self.dinghy
    where("length < 20")
    # where is used as a filter 
  end

  def self.ship
    where("length >= 20")
    # conflicts with above, can't be combined with self.dinghy  
  end

  def self.last_three_alphabetically
    all.order(name: :desc).limit(3)
    # reversed order => Boat.order(name: :asc).last(3) 
  end

  def self.without_a_captain
    where(captain_id: nil)
  end

  def self.sailboats
    includes(:classifications).where(classifications: { name: 'Sailboat' }) 
    # We are getting information from both the boats table and the classifications table. We are joining 3 tables, (boat, classification, and boat_classsification) 
    # We are able to call :classifications because of the has_many :classifications, through :boat_classifications macro  (This part creates two joins)
    # Includes let's us query multiple tables at once. where allows us to query an additional table with a filter.   
    # With includes, Active Record ensures that all of the specified associations are loaded using the minimum possible number of queries.
    # Includes is used to look for records that have been associated with another record 
  end

  def self.with_three_classifications
    joins(:classifications).group("boats.id").having("COUNT(*) = 3").select("boats.*") 
    # This is really complex! It's not common to write code like this
    # regularly. Just know that we can get this out of the database in
    # milliseconds whereas it would take whole seconds for Ruby to do the same.
  end

  def self.non_sailboats
    where("id NOT IN (?)", self.sailboats.pluck(:id))
  end

  def self.longest
    order('length DESC').first
    # This is not a scope method because of .first 
    # It's a scope method if it returns an ARR  
    # A scope method is a Class Method that returns an ARR 
    # If it doesn't return an ARR it's not a scope method 
  end
end

# You might have a situation where you're looking for all of the records that have been associated with another record in a certain way. You will need to include the join record in this method so that you can have a WHERE clause that looks inside of the JOIN table in order to filter out things. Where some user submittable attribute on the join model isn't what you wanted it to be. 

# The main reason this is used if you need to have a WHERE clause attached to a model but there WHERE clause is checking things in another table. You would want all of the records in one table where something is true about related records so yo uneed to include related records includes creates the join. So you're able to make a query that includes related information in another tbale. 


# GROUP  if we use this we're able to use aggregate functions like SUM, AVG, COUNT  
# When using GROUP we have to use HAVING we cannot use WHERE 

# Regarding Project: 
# Use the rails console and SQLite Extension 
# Use a seeds file and run rails db:seed
# Scope Methods returns an ARR 
# Refer to this lesson for Scope Methods 