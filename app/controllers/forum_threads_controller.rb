class ForumThreadsController < ApplicationController
  before_action :set_forum_thread, only: %i[ show edit update destroy ]
  authorize_resource

  # GET /forum_threads or /forum_threads.json
  def index
    @forum_threads = ForumThread.all
  end

  # GET /forum_threads/1 or /forum_threads/1.json
  def show
    @posts = @forum_thread.posts
    @post = Post.new
  end

  # GET /forum_threads/new
  def new
    if params[:forum_id]
      @forum_thread = ForumThread.new
      @forum_thread.forum_id = params[:forum_id]
    else
      format.html { render :index ,status: :bad_request}
    end

  end

  # GET /forum_threads/1/edit
  def edit
  end

  # POST /forum_threads or /forum_threads.json
  def create
    @forum_thread = ForumThread.new(forum_thread_params)

    respond_to do |format|
      if @forum_thread.save
        format.html { redirect_to forum_thread_url(@forum_thread), notice: "Forum thread was successfully created." }
        format.json { render :show, status: :created, location: @forum_thread }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @forum_thread.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /forum_threads/1 or /forum_threads/1.json
  def update
    respond_to do |format|
      if @forum_thread.update(forum_thread_params)
        format.html { redirect_to forum_thread_url(@forum_thread), notice: "Forum thread was successfully updated." }
        format.json { render :show, status: :ok, location: @forum_thread }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @forum_thread.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /forum_threads/1 or /forum_threads/1.json
  def destroy
    @forum_thread.destroy

    respond_to do |format|
      format.html { redirect_to forum_threads_url, notice: "Forum thread was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_forum_thread
      @forum_thread = ForumThread.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def forum_thread_params
      params.require(:forum_thread).permit(:title,:forum_id)
    end
end
