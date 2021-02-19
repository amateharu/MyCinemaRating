require 'rails_helper'

RSpec.describe Comment, type: :model do
  subject { described_class.new(body: 'test5') }

  before { subject.save }
  
  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a title" do
    subject.body = nil
    expect(subject).to_not be_valid
  end

  it "length is too short" do
    subject.body = 'test'
    expect(subject).to_not be_valid
  end
end
