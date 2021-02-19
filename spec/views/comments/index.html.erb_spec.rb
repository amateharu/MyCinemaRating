require 'rails_helper'

RSpec.describe "comments/index.html.erb", type: :view do
  it 'displays all the comments' do
    assign(:comments, [
      Comment.create!(body: 'test5'),
      Comment.create!(body: 'test6')
      ])

    render

    expect(rendered).to match /test5/
    expect(rendered).to match /test6/
  end
end
