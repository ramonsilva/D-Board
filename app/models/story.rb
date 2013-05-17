class Story < ActiveRecord::Base
  attr_accessible :name
  #TODO spec
  has_many :tasks
end
