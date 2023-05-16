class PostsController < ApplicationController
  load_and_authorize_resource
  # GET /posts/1 or /posts/1.json
  def show
    unless @post.user_id.nil?
      user = User.find(@post.user_id)
      @nickname = user.nickname
      unless @nickname
        @nickname = user.email
      end
    end

  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)
    @post.user = Current.user
    redirect_thread = ForumThread.find_by_id(@post.forum_thread_id)

    respond_to do |format|
      if @post.save
        format.html { redirect_to forum_threads_url(redirect_thread), notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: redirect_thread }
      else
        # Keep track of forum_thread as user input errors are reported.
        if defined?(post_params[:forum_thread_id])
          @forum_thread = ForumThread.find_by_id(post_params[:forum_thread_id])
        end
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title,:body,:forum_thread_id)
    end


end
