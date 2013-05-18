require 'spec_helper'

describe Task do
  it { should belong_to(:story) }
  it { should validate_presence_of(:status) }
  it { should validate_presence_of(:description) }
  it { should allow_mass_assignment_of(:description) }
  it { should allow_mass_assignment_of(:status) }
  it { should allow_mass_assignment_of(:story_id) }

  context "status scope" do
    before :all do
      4.times do |x|
        x += 1
        Task.create! description: "Task #{x}", status: x 
      end
    end
    it { Task.to_do     == Task.where(status: Task::TO_DO) }
    it { Task.doing     == Task.where(status: Task::DOING) }
    it { Task.to_verify == Task.where(status: Task::TO_VERIFY) }
    it { Task.done      == Task.where(status: Task::DONE) }
  end
end
