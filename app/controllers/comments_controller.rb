class CommentsController < ApplicationController
  http_basic_authenticate_with name: "dhh", password:
  "secret", only: :destroy

  # The create action is responsible for creating a new comment record in the database 
  # with the values for the commenter and body columns taken from the params hash. 
  # If the comment saves successfully, the user is redirected to the article's show page. 
  # If the comment fails to save, the article's show template is rendered again with the @comment variable passed in.
  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)

    redirect_to article_path(@article)
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to article_path(@article), status: :see_other
  end

  private
    def comment_params
      params.require(:comment).permit(:commenter, :body, :status)
    end
end
