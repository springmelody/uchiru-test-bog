# frozen_string_literal: true

require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @comment = post_comments(:one)
    @post = @comment.post
    @attrs = {
      body: Faker::Movies::BackToTheFuture.quote
    }
  end

  test 'should create comment' do
    post post_comments_url(@post), params: { post_comment: @attrs }

    assert_response :redirect

    comment = Post::Comment.find_by(@attrs)

    assert { comment }
  end

  test 'should get edit' do
    get edit_post_comment_url(@post, @comment)
    assert_response :success
  end

  test 'should update comment' do
    patch post_comment_url(@post, @comment), params: { post_comment: @attrs }

    @comment.reload

    assert { @comment.body == @attrs[:body] }
    assert_redirected_to post_url(@post)
  end

  test 'should destroy comment' do
    delete post_comment_url(@post, @comment)

    assert { !Post::Comment.exists?(@comment.id) }

    assert_redirected_to post_url(@post)
  end
end
