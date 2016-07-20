class VisitorsController < ApplicationController
  layout 'visitors'
  def index
    @posts = Post.yes.all
  end
end
