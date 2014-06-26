class PressController < ApplicationController
  def index
    @articles = Article.press.published
  end
end
