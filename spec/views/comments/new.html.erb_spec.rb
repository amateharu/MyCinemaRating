require 'rails_helper'

RSpec.describe "comments/new.html.erb", type: :view do
  it 'displays the form for new comment' do
    assign(:comment, Comment.create!(body: 'test5'))

    render template: 'comments/new.html.erb'

    expect(rendered).to match /test5/
  end
end
