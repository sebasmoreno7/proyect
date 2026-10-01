require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @owner = User.create!(email: 'owner@example.com', password: 'password123')
    @other = User.create!(email: 'other@example.com', password: 'password123')
    @post = @owner.posts.create!(title: 'Original', description: 'Owner content')
  end

  test 'anonymous users cannot create posts' do
    assert_no_difference 'Post.count' do
      post posts_path, params: { post: { title: 'Unauthorized' } }
    end
    assert_redirected_to new_user_session_path
  end

  test 'a signed-in user cannot change another users post' do
    sign_in @other

    patch post_path(@post), params: { post: { title: 'Changed' } }

    assert_redirected_to posts_path
    assert_equal 'Original', @post.reload.title
  end

  test 'a signed-in user cannot delete another users post' do
    sign_in @other

    assert_no_difference 'Post.count' do
      delete post_path(@post)
    end
    assert_redirected_to posts_path
  end

  test 'a submitted user id cannot change the owner of a new post' do
    sign_in @other

    assert_difference 'Post.count', 1 do
      post posts_path, params: { post: { title: 'New', user_id: @owner.id } }
    end
    assert_equal @other, Post.order(:id).last.user
  end
end
