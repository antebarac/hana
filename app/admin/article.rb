ActiveAdmin.register Article do
  permit_params :id, :category_id, :title, :body, :is_published, attachments_attributes: [:title, :image, :is_main, :article_id, :_destroy, :image_cache, :id]
  
  form do |f|
    f.inputs do 
      f.input :locale, :label => 'Jezik', :as => :select, :collection => [ ["Bošnjački", :ba], ["Engleski", :en], ["Hrvatski", :hr], ["Makedonski", :mk], ["Srpski", :sr] ]
      f.input :is_published
      f.input :category
      f.input :title
      f.input :body, input_html: { class: 'redactor' }
    end

    f.inputs do
      f.has_many :attachments, :allow_destroy => true, :heading => I18n.t(:attachments), :new_record => true do |att|
        att.input :title, :hint => f.template.label_tag(att.object.image_url)
        att.input :image, :as => :file, :hint => f.template.image_tag(att.object.image.url) 
        att.input :image_cache, :as => :hidden 
        att.input :is_main
        att.input :article_id, as: :hidden
        att.input :id, as: :hidden
      end
    end

    f.actions
  end

  index do
    selectable_column
    column :locale
    column :category do |article|
      article.category.name
    end
    column :title do |article|
     link_to article.title, admin_article_path(article)
    end
    column :is_published
    column :created_at
    actions
  end

  show do |article|
    div do
      article.body.html_safe
    end
  end
end

  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end
  
