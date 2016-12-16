class Category < ApplicationRecord
  acts_as_nested_set

  rails_admin do
    nested_set({
        max_depth: 15,
        toggle_fields: [:enabled],
        thumbnail_fields: [:image, :cover],
        thumbnail_size: :thumb,
        thumbnail_gem: :paperclip#, # or :carrierwave
        #scopes: [:deleted, :disabled] # filter nodes by scope
    })
  end

  # TO DO: Refactor following logic to apply texts: Maybe move to a module and send texts to locales.

  def vehicle?
    root.name == 'Vehículo'
  end

  def promotion_action_button_name
    case vehicle?
    when true
      'Solicita información'
    else
      'Genera tu Cupón'
    end
  end

  def promotion_confirm_action_button_name
    case vehicle?
    when true
      'Quiero más información' # Never used
    else
      'Generar mi Cupón'
    end
  end

  def promotion_before_registration_text
    case vehicle?
    when true
      'Estás solicitando información para'
    else
      'Ingresa tus datos para generar tu Cupón'
    end
  end

  def promotion_confirmed_text
    case vehicle?
    when true
      'Que ponemos aqui'
    else
      'Ya puedes generar tu cupón para tu'
    end
  end
end
