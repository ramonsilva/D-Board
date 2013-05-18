require 'spec_helper'

describe Task do
  it { should belong_to(:story) }
  it { should validate_presence_of(:status) }
  it { should validate_presence_of(:description) }
end
