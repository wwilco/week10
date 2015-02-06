class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end
  def new
    @article = Article.new
  end
  def create
    @article = Article.create(article_params)
    redirect_to @article
  end
  def show
    @article = Article.find_by(id: params[:id])
  end
  
  def destroy
    @article = Article.find_by(id: params[:id])
    @article.destroy

    redirect_to articles_path
  end

  def edit
    @article = Article.find_by(id: params[:id])
  end

  def update
    @article = Article.find_by(id: params[:id])
    @article.update_attributes(article_params)

    redirect_to @article
  end

  private
  def article_params
    params.require(:article).permit(:title, :author, :content)
  end
end
