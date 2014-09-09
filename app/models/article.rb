class Article < ActiveRecord::Base
  has_many :attachments
  belongs_to :category

  accepts_nested_attributes_for :attachments, allow_destroy: true

  default_scope {
    includes(:category).includes(:attachments).where(locale: I18n.locale).order(created_at: :desc)
  }

  scope :published, -> {
    where(is_published: true)
  }

  scope :news_and_press, -> {
    where(categories: { name: ['news', 'press'] })
  }

  scope :documents, -> {
    where(categories: { name: 'documents' })
  }

  scope :press, -> {
    where(categories: { name: 'press' })
  }

  def title_image
    if attachments.where(is_main: true).size > 0
      attachments.where(is_main: true).first.image
    elsif attachments.size > 0
      attachments.first.image
    else
      nil
    end
  end

  def first_non_title
    if attachments.where(is_main: false).size > 0
      attachments.where(is_main: false).first.image
    else
      nil
    end
  end
end
