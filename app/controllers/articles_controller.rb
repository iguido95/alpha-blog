class ArticlesController < ApplicationController
	before_action :set_article_by_id, only: [:edit, :update, :show, :destroy]
	before_action :require_user, except: [:index, :show]
	before_action :require_same_user, only: [:edit, :update, :destroy]

	def index
		@articles = Article.paginate(page: params[:page], per_page: 4).includes(:user).order(created_at: :desc)
		# @articles = Article.all.includes(:user).order(created_at: :desc)
	end

	def new
		@article = Article.new
	end

	def edit
	end

	def create
		@article = Article.new(article_params)
		@article.user = current_user
		if @article.save
			flash[:success] = "Article was successfully created"
			redirect_to article_path(@article)
		else
			flash[:danger] = "Article was not saved"
			render 'new'
		end
	end

	def update
		if @article.update(article_params)
			flash[:success] = "Article was successfully updated"
			redirect_to article_path(@article)
		else
			render 'edit'
		end
	end

	def show
	end

	def destroy
		@article.destroy
		flash[:success] = "Article #{@article.id} was successfully deleted"
		redirect_to articles_path
	end


	private
	def set_article_by_id
		@article = Article.find(params[:id])
	end

	def article_params
		params.require(:article).permit(:title, :description)
	end

	def require_same_user
    unless same_user?(@article.user)
      flash[:danger] = "You don't have the autorization to perform that action"
      redirect_to login_path
    end
  end

end
