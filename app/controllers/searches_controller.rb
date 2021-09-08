class SearchesController < ApplicationController
  before_action :authenticate_user!

	def search
		@model = params[:model]        #選択したmodelを@modelに代入
		@content = params[:content]    #検索にかけた文字列（centent)を@cententに代入
		@method = params[:method]      #選択した検索方法methodを@methodに代入
		if @model == 'user'
			@records = User.search_for(@content, @method)
		else
			@records = Article.search_for(@content, @method).page(params[:page]).per(6)
		end
	end

end
