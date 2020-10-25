class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    all
  end

  def self.longest
    Boat.longest.classifications
    # coming from the has_many macro in Boat 
    # This method will return a collection proxy not a relation 
  end

end
