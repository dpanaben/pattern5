class PostsController < ApplicationController
  before_action :set_post, except: [:index, :new, :create]
  before_action :get_active_sanitize, only: [:index, :show, :brew, :result]

  # GET /posts
  # GET /posts.json
  #首頁依權限給資料，admin看全部，user看自己的
  def index
    current_user.admin? ? @posts = Post.includes(:author) : @posts = current_user.posts.includes(:author)
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy #這邊destroy之後會代dependent: :nullify把post的user_id改成admin的
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def undo
    @post = @post.previous_version
    @post.save
    redirect_to @post, notice: 'Congrats! The post has been recovered to the last version!'
  end

  def brew
    @post.replacesomething
    @post.save
    redirect_to result_post_path, notice: 'Your post has been brewed!'
  end

  def result
  end


  private
    #抓status = on 的規則
    def get_active_sanitize
      @sanitizes = Sanitize.on.all
    end

    # 如果是admin就抓全部的post，如果是其他人就只抓個人所屬的post
    def set_post
      if current_user.admin?
        @post = Post.find_by(id: params[:id])
      else
        @post = current_user.posts.find_by(id: params[:id])
      end
      if @post.nil?
        redirect_to root_url, notice: "No post was found!"
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :content)
    end
end
