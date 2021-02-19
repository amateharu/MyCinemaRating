# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'routes to the comments controller', type: :routing do
  it 'routes a new route' do
    expect(get: new_comment_path)
      .to route_to(controller: 'comments', action: 'new')
  end

  it 'routes an all route' do
    expect(get: comments_path)
      .to route_to(controller: 'comments', action: 'index')
  end

  it 'routes a create route' do
    expect(post: comments_path)
      .to route_to(controller: 'comments', action: 'create')
  end

  it 'routes an edit route' do
    expect(get: edit_comment_path(1))
      .to route_to(controller: 'comments', action: 'edit', id: '1')
  end

  it 'routes a show route' do
    expect(get: comment_path(1))
      .to route_to(controller: 'comments', action: 'show', id: '1')
  end

  it 'routes an update route' do
    expect(put: comment_path(1))
      .to route_to(controller: 'comments', action: 'update', id: '1')
  end

  it 'routes a destroy route' do
    expect(delete: comment_path(1))
      .to route_to(controller: 'comments', action: 'destroy', id: '1')
  end

  it 'does not route to comments/foo/bar' do
    expect(get: '/comments/foo/bar').not_to be_routable
  end
end
