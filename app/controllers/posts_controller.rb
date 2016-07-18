class PostsController < ApplicationController
  before_action :set_post, except: [:index, :new, :create]
  before_action :get_active_sanitize, only: [:index, :show, :brew, :result]
  after_action :verify_authorized

  # GET /posts
  # GET /posts.json
  #首頁依權限給資料，admin看全部，user看自己的
  def index
    @posts = policy_scope(Post) #@posts = UserPolicy::Scope.new(current_user, Post).resolve
    authorize Post #raise "not authorized" unless PostPolicy.new(current_user, Post).index?
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    authorize @post
  end

  # GET /posts/new
  def new
    @post = Post.new
    authorize @post
  end

  # GET /posts/1/edit
  def edit
    authorize @post
  end

  # POST /posts
  # POST /posts.json
  def create
    authorize Post
    @post = current_user.posts.build(post_params)
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
    authorize @post
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
    authorize @post
    @post.destroy #這邊destroy之後會代dependent: :nullify把post的user_id改成admin的
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def undo
    @post = @post.previous_version
    authorize @post
    @post.save
    redirect_to @post, notice: 'Congrats! The post has been recovered to the last version!'
  end

  def brew
    authorize @post
    @post.replacesomething
    @post.save
    redirect_to result_post_path, notice: 'Your post has been brewed!'
  end

  def result
    authorize @post
  end


  private
    #抓status = on 的規則
    def get_active_sanitize
      @sanitizes = Sanitize.on.all
    end

    # 如果是admin就抓全部的post，如果是其他人就只抓個人所屬的post
    def set_post
      @post = Post.find_by(id: params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :content)
    end
end
