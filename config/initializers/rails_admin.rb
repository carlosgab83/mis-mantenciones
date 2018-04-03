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

  config.actions do
    dashboard do
      statistics false
    end
    index                         # mandatory
    new do
      except ['SystemSetting']
    end
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ###########################
    ### CUSTOM ACTIONS ########
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
        field :slug
        field :parent
      end

      edit do
        field :name
        field :slug
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

    config.model 'Product' do
      edit do
        field :name
        field :product_brand
        field :deleted
        field :status
        field :category
        field :branches
        field :image_url
        field :slug
        field :price
      end

      list do
        field :id
        field :name
        field :category
        field :status
      end
    end

    config.model 'Branch' do
      list do
        field :id
        field :name
        field :shop
        field :branch_type
        field :plan
      end

      edit do
        field :name
        field :email
        field :info_email
        field :phone1
        field :phone2
        field :address
        field :will_contact
        field :booking_url
        field :scraper_model
        field :deleted
        field :shop
        field :commune_id
        field :latitude
        field :longitude
        field :branch_type
        field :plan
        field :interval_between_jumps
        field :slug
        field :checkout_method
      end
    end

    config.model 'BranchesProduct' do
      list do
        field :id
        field :branch_id
        field :product_id
        field :price
        field :url
      end

      edit do
        field :price
        field :from_date
        field :to_date
        field :status
        field :stock
        field :url
        field :scraping
        field :deleted
        field :branch_id
        field :product_id
        field :checkout_method
      end
    end

    config.model 'BranchesPromotion' do
      edit do
        field :deleted
        field :branch
        field :promotion
        field :price
      end
    end

    config.model 'Shop' do
      list do
        field :id
        field :name
        field :rut
        field :status
        field :slug
      end
    end

    config.model 'BranchesManteinanceItem' do
      list do
        field :id
        field :manteinance_item
        field :pauta
        field :branch
      end
    end

    config.model 'PromotionsVme' do
      list do
        field :id
        field :promotion
        field :vme
        field :from_year
        field :to_year
      end
    end

    config.model 'ProductsVme' do
      list do
        field :id
        field :product
        field :vme
        field :from_year
        field :to_year
      end
    end


    config.model 'SearchCategorySetting' do
      list do
        field :id
        field :category
        field :category_attribute
        field :filter_type
        field :position
        field :deleted
      end
    end

    config.model 'Promotion' do
      edit do
        include_all_fields
      end
    end

    config.model 'BranchInformation' do
      edit do
        field :branches do
          associated_collection_cache_all true
        end
        include_all_fields
      end
    end

    # config.model 'Manteinance' do
    #   edit do
    #     field :branches do
    #       associated_collection_cache_all true
    #     end
    #     include_all_fields
    #   end
    # end

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end

end
