class ArticlesController < ApplicationController
  layout 'dashboard', except: :show
  before_action :authenticate_user!
  before_filter :set_user, only: [:index, :new, :create, :edit, :update, :destroy]
  before_filter :set_article, only: [:edit, :update, :destroy]
  before_filter :set_error_not_found, only: :show

  def index
    @articles = @user.articles
  end

  def show
    @article = Article.friendly.find(params[:id])
    if @article
      respond_to do |format|
        format.html { @article }
        format.json { render json: @article.to_json() }
      end
    end
  end

  def new
  	@article ||= Article.new
  	render
  end

  def create
    @article = @user.articles.new(article_params)
    if @article.save
      redirect_to articles_path, notice: "Well done brah! Your article has been publish"
    else
      render 'new'
    end
  end

  def edit
    if @article
      render
    else
      redirect_to articles_path, notice: "Oppss! Article not found"
    end
  end

  def update
    if @article.update(article_params)
      redirect_to articles_path, notice: "U-la-la! Your article has been update"
    else
      render 'edit'
    end
  end

  def destroy
    if @article.destroy
      redirect_to articles_path, notice: 'Shoot! Article was destroyed!'
    else
      render 'index'
    end
  end

  private

    def set_user
    	@user = current_user
    end

    def set_article
      @article = Article.where(slug: params[:id], user: @user).take
    end

    def set_error_not_found
      @article = Article.friendly.find(params[:id])
      # redirect back to previous page if record not found
      rescue ActiveRecord::RecordNotFound => e
      flash[:notice] = "Oppss! Article not found"
      redirect_to root_path
    end
end
