#post_conttroller.rb, in the concerns subfolder of controller folder
#post=>{"title"=>"something", "author"=>"some name", "content"=>"more content"}
class PostsController <ApplicationController
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new #only ceates a new class, doesnt actually write anything,
  end                #so you need have a create method

  def create
    @post = Post.create
    redirect_to post_path(@post) # can also just do: redirect_to @post
  end

  def show
    @post = Post.find #automatically searches for ID
    @post = Post.find_by(id: params[:id])
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    redirect_to posts_path #need to go back to posts because psot was destroyed
  end

  def edit
    @post = Post.find_by(id: params[:id])
    @post.update(post_params) #post_params when client is changing something

    redirect_to post_path(@path)
  end


  private #not allowed to change multiple things unless you say its ok
  def post_params
    params.require(:post).permit(:title, :author, :content)
  end

end
