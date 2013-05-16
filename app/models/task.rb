class Task < ActiveRecord::Base
  belongs_to :story
  attr_accessible :description, :status
end
