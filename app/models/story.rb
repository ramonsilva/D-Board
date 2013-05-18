class Story < ActiveRecord::Base
  attr_accessible :name
  has_many :tasks
  validates_presence_of :name
  validates_uniqueness_of :name
end
