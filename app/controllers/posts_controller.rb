class PostsController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
    before_action :set_post, only: [:show, :edit, :update, :destroy]
    before_action :authorize_post!, only: [:edit, :update, :destroy]
        def index
      @posts = Post.all
        end
  
    # GET /burgers/1
    # GET /burgers/1.json
    def show
    end
  
    # GET /burgers/new
    def new
      @post = Post.new
    end
  
    # GET /burgers/1/edit
    def edit
       @post = Post.find(params[:id])
    end
    
  
    # POST /burgers
    # POST /burgers.json
    def create
      @post = current_user.posts.new(post_params)
  
  
        if @post.save
           redirect_to @post, notice: 'Post was successfully created.'
  
        else
           render :new
  
        end
    end
  
    # PATCH/PUT /burgers/1
    # PATCH/PUT /burgers/1.json
    def update
  
        if @post.update(post_params)
           redirect_to @post, notice: 'Post was successfully updated.'
  
        else
          render :edit
  
        end
    end
  
    # DELETE /burgers/1
    # DELETE /burgers/1.json
    def destroy
      @post.destroy
      redirect_to "/posts"
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_post
        @post = Post.find(params[:id])
      end
  
      def authorize_post!
        redirect_to posts_path, alert: 'Not authorized' unless @post.user == current_user
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def post_params
        params.require(:post).permit(:title, :description, :image)
      end
  end