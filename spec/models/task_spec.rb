require 'spec_helper'

describe Task do
  it { should belong_to(:story) }
  it { should validate_presence_of(:status) }
  it { should validate_presence_of(:description) }
  it { should allow_mass_assignment_of(:description) }
  it { should allow_mass_assignment_of(:status) }
  it { should allow_mass_assignment_of(:story_id) }
end
