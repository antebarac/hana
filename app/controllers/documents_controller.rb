class DocumentsController < ApplicationController
  def index
    @articles = Article.published.documents
  end
end
