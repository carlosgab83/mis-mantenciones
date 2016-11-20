  RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar true

  RailsAdmin::Config::Actions.register(RailsAdmin::Config::Actions::XlsUpload)
  RailsAdmin::Config::Actions.register(RailsAdmin::Config::Actions::XlsMatrixUpload)

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ###########################
    ### CUSTOM ACTIONS ########
    root :xls_matrix_import do
      register_instance_option :link_icon do
          'icon-upload'
        end
    end
    xls_matrix_upload

    root :xls_import do
      register_instance_option :link_icon do
          'icon-upload'
        end
    end
    xls_upload

    ###########################
    ### AWESOME NESTED SET ####

    nested_set do
      visible do
         bindings[:abstract_model].model_name
      end
    end

    ###########################
    ### CHANGE VIEWS ##########

    config.model 'Category' do
      list do
        field :id
        field :name
        field :parent
      end

      edit do
        field :name
      end
    end

    config.model 'AttributesProduct' do
      list do
        field :product_attribute
        field :product
        field :value
        field :deleted
      end
    end

    config.model 'AttributesPromotion' do
      list do
        field :promotion_attribute
        field :promotion
        field :value
        field :deleted
      end
    end


    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end

end
