class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def index
    @articles = Article.page(params[:page]).per(2)
  end
  def singlearticle
    @article = Article.find_by_id(params[:id])
    @comments = @article.comments.order("id desc")
    @comment = Comment.new
  end
  def Comment
    @comment = Comment.new(comment_params)

    respond_to do |format|
      if @comment.save
        format.js {@comments = Article.find_by_id(params[:comment][:article_id]).comments.order("id desc")}
      else
        format.js {@article = Article.find_by_id(params[:comment][:article_id])}
      end
    end
  end

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden, content_type: 'text/html' }
      format.html { redirect_to main_app.home_path, notice: exception.message }
      format.js   { head :forbidden, content_type: 'text/html' }
    end
  end

  private
    def set_commentable
        @article = Article.find(params[:article_id])
    end

    def comment_params
      params.require(:comment).permit(:body, :author, :article_id)
    end
end
