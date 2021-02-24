require 'rails_helper'

RSpec.describe Rating, type: :model do
  subject { Rating.new(user_rating: 5) }

  it 'should be valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'should be not valid without valid attributes' do
    subject = Rating.new
    expect(subject).to_not be_valid
  end

  it 'should belongs to film' do
    should belong_to(:film).optional
  end
end
