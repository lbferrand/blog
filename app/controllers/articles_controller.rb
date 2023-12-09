class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  # the create action is responsible for creating a new article record in the database 
  # with the values for the title and body columns taken from the params hash. 
  # If the article saves successfully, the user is redirected to the article's show page. 
  # If the article fails to save, the new template is rendered again with the @article variable passed in.
  
  def create
    @article = Article.new(article_params) 

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  # The edit action is responsible for retrieving the article from the database and 
  # stores it in the @article instance variable when building the form.

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article= Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # Add private method to the bottom of the controller file. 
  # This method will avoid for malicious users could potentially submit extra form fields and 
  # overwrite existing values in the database.
  private
    def article_params
      params.require(:article).permit(:title, :body)
    end
end
