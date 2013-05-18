require 'spec_helper'

describe Story do
  it { should have_many :tasks }
  it { should validate_presence_of :name }
  it { should validate_uniqueness_of  :name }
end
