class Task < ActiveRecord::Base
  belongs_to :story
  attr_accessible :description, :status, :story_id
  validates_presence_of :description, :status
  TO_DO = 1
  DOING = 2
  TO_VERIFY = 3
  DONE = 4
  scope :to_do, where(status: TO_DO)
  scope :doing, where(status: DOING)
  scope :to_verify, where(status: TO_VERIFY)
  scope :done, where(status: DONE)
end
