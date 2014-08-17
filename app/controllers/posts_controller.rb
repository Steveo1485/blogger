class PostsController < ApplicationController

  def index
    @posts = Post.active
  end

  def show
    @post = Post.find(params[:id])
  end
end