class Task < ActiveRecord::Base
  belongs_to :story
  attr_accessible :description, :status, :story_id
  validates_presence_of :description, :status
end
