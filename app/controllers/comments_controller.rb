# frozen_string_literal: true

class CommentsController < ApplicationController
  include SessionsHelper
  def index
    @comments = Comment.all
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def new
    @film = Film.find(params[:film_id])
    @comment = @film.comments.new
  end

  def create
    @film = Film.find(params[:film_id])
    @comment = @film.comments.new(comment_params)
    @comment.user_id = current_user.id
    @comment.username = current_user.name
    if @comment.save
      flash[:success] = 'Comment has been created!'
      redirect_to film_path(@film)
    else
      flash[:danger] = 'Something went wrong.'
      render :new
    end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      flash[:success] = 'Comment has been updated!'

      redirect_to @comment
    else
      render :edit
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    redirect_to root_path
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
