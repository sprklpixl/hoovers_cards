ActiveAdmin.register Spree::User do
  permit_params :email, :password, :password_confirmation, spree_role_ids: []

  index do
    selectable_column
    id_column
    column :email
    column :created_at
    column :last_sign_in_at
    actions
  end

  form do |f|
    f.inputs 'User Details' do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :spree_roles, as: :check_boxes, collection: Spree::Role.all
    end
    f.actions
  end

  show do
    attributes_table do
      row :email
      row :created_at
      row :last_sign_in_at
    end

    panel 'Roles' do
      table_for user.spree_roles do
        column :name
      end
    end
  end

  controller do
    def update
      if params[:spree_user][:password].blank?
        params[:spree_user].delete("password")
        params[:spree_user].delete("password_confirmation")
      end
      super
    end
  end
end
