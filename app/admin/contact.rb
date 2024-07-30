ActiveAdmin.register Contact do
  permit_params :title, :content, :address, :phone, :email, :facebook, :twitter, :instagram, :tiktok, :snapchat

  form do |f|
    f.inputs do
      f.input :title
      f.input :content, label: 'Description', as: :text
      f.input :address
      f.input :phone
      f.input :email
      f.input :facebook
      f.input :twitter, label: 'X'
      f.input :instagram
      f.input :tiktok
      f.input :snapchat
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :title
    column :address
    column :phone
    column :email
    actions
  end

  show do
    attributes_table do
      row :title
      row :content
      row :address do |contact|
        link_to contact.address, "https://www.google.com/maps?q=#{CGI.escape(contact.address)}", target: "_blank"
      end
      row :phone do |contact|
        mail_to "tel:#{contact.phone}", contact.phone
      end
      row :email do |contact|
        mail_to contact.email
      end
      row :facebook
      row :twitter, label: 'X'
      row :instagram
      row :tiktok
      row :snapchat
    end
  end
end
