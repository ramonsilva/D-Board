class Task < ActiveRecord::Base
  belongs_to :story
  attr_accessible :description, :status
  validates_presence_of :description, :status
end
