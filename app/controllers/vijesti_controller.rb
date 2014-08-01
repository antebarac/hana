class VijestiController < ApplicationController
  before_filter :authenticate   

  def index
    @articles = Article.news_and_press.published
  end

  def show
    @article = Article.find(params[:id])
    render layout: nil
  end
end
