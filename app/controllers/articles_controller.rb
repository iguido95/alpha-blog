class ArticlesController < ApplicationController

	def index
		@articles = Article.paginate(page: params[:page], per_page: 4).includes(:user).order(created_at: :desc)
		# @articles = Article.all.includes(:user).order(created_at: :desc)
	end

	def new
		@article = Article.new
	end

	def edit
		@article = Article.find(params[:id])
	end

	def create
		@article = Article.new(article_params)
		@article.user = User.first
		if @article.save
			flash[:success] = "Article was successfully created"
			redirect_to article_path(@article)
		else
			flash[:danger] = "Article was not saved"
			render 'new'
		end
	end

	def update
		@article = Article.find(params[:id])

		if @article.update(article_params)
			flash[:success] = "Article was successfully updated"
			redirect_to article_path(@article)
		else
			render 'edit'
		end
	end

	def show
		@article = Article.find(params[:id])
	end

	def destroy
		@article = Article.find(params[:id])
		@article.destroy
		flash[:danger] = "Article #{@article.id} was successfully deleted"
		redirect_to articles_path
	end

	private
	def article_params
		params.require(:article).permit(:title, :description)
	end

end
