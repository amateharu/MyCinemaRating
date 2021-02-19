require 'rails_helper'

RSpec.describe "comments/show.html.erb", type: :view do
  it 'displays the comment' do
    assign(:comment, Comment.create!(body: 'test5'))

    render template: 'comments/show.html.erb'

    expect(rendered).to match /test5/
  end
end
