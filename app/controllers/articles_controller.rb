class ArticlesController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def index
    @articles = Article.all.order(created_at: :desc)
    # @page = Article.all.page(params[:page]).per(2)
    @tags = Hashtag.select('id', 'hashname').order('hashname ASC')
  end

  def show
    @article = Article.find(params[:id])
    @tag = Hashtag.find_by(hashname: params[:name])
  end

  def new
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  def create
    @article = Article.new(article_params)
    @article.user_id = current_user.id
    if @article.save
      redirect_to articles_path(@article), notice: "投稿しました！"
    else
      render 'new'
    end
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to articles_path(@article), notice: "更新しました！"
    else
      render "edit"
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path
  end

  def hashtag
    @user = current_user
    @tag = Hashtag.find_by(hashname: params[:name])
    if @tag.present?
      @articles = @tag.articles
      @tags = Hashtag.select('id', 'hashname').order('hashname ASC')
    else
      redirect_to request.referer
      #ページ遷移しない
    end
  end


  private

  def article_params
    params.require(:article).permit(:title, :image, :body,)
  end


  def ensure_correct_user
    @article = Article.find(params[:id])
    unless @article.user == current_user
      redirect_to articles_path
    end
  end


end
