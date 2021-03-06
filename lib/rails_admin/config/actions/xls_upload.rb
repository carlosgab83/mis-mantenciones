# encoding: utf-8
require 'rails_admin/config/actions'
require 'rails_admin/config/actions/base'
require 'merge_raw_importer/importer'

module RailsAdmin
  module Config
    module Actions
      class XlsUpload < RailsAdmin::Config::Actions::Base

        register_instance_option :root do
          true
        end

        register_instance_option :visible? do
          false
        end

        register_instance_option :http_methods do
          [:get, :post]
        end

        register_instance_option :controller do
          proc do
            if params[:xls_import].nil? or params[:xls_import][:file].blank?
              flash[:alert] = "Por favor selecciona un archivo, recuerda que el nombre del mismo debe ser el de la tabla a importar"
              redirect_to :xls_import
            else
              begin
                importer = MergeRawImporter::Importer.new(table_name: params[:xls_import][:file].original_filename.split(".").first)
                importer.import(params[:xls_import][:file].tempfile.path)
                flash[:notice] = "Archivo importado exitosamente"
                redirect_to :xls_import

              rescue
                flash[:alert] = $!.message
                redirect_to :xls_import
              end
            end
          end
        end

        register_instance_option :link_icon do
        #  'icon-eye-open'
        end

        register_instance_option :pjax? do
          true
        end
      end
    end
  end
end