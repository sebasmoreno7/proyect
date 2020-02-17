class PagesController <  ApplicationController

    before_action :set_page, only: [:show, :edit, :update, :destroy]
        def index
      @pages = Page.all
        end
  
    # GET /burgers/1
    # GET /burgers/1.json
    def show
    end
  
    # GET /burgers/new
    def new
      @page = Page.new
    end
  
    # GET /burgers/1/edit
    def edit
       @page = Page.find(params[:id])
    end
    
  
    # POST /burgers
    # POST /burgers.json
    def create
      @page = current_user.pages.new(page_params)
  
  
        if @page.save
           redirect_to @page, notice: 'Page was successfully created.'
  
        else
           render :new
  
        end
  
    end
  
    # PATCH/PUT /burgers/1
    # PATCH/PUT /burgers/1.json
    def update
  
        if @page.update(page_params)
           redirect_to @page, notice: 'Page was successfully updated.'
  
        else
          render :edit
  
        end
    end
  
    # DELETE /burgers/1
    # DELETE /burgers/1.json
    def destroy
      Page.find(params[:id]).destroy
      redirect_to "/posts"
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_post
        @post = Post.find(params[:id])
      end
  
      # Never trust parameters from the scary internet, only allow the white list through.
      def post_params
        params.require(:post).permit(:title, :user_id, :description, :image)
      end
  end