require 'rails_helper'

RSpec.describe "comments/edit.html.erb", type: :view do
  it 'displays the form for update the comment' do
    assign(:comment, Comment.create!(body: 'test5'))

    render template: 'comments/edit.html.erb'

    expect(rendered).to match /test5/
  end
end
