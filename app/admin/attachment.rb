ActiveAdmin.register Attachment do
  permit_params :title, :image, :is_main, :article_id  
  
end
