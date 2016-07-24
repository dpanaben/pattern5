class VisitorsController < ApplicationController
  protect_from_forgery except: :create
  layout 'visitors'

  def index
    redirect_to new_visitor_path
  end

  def new
    @posts = Post.yes.all
    @visitor = Visitor.new
    session[:referrer] ||= request.env["HTTP_REFERER"] || 'none'
    @visitor.referrer ||= session[:referrer] || 'none'
  end

  def create
    @visitor = Visitor.new(params.require(:visitor).permit(:email, :affinity, :referrer))
    if @visitor.save
      redirect_to root_path, notice: "Signed up #{@visitor.email}."
    else
      render :new
    end
  end

end
