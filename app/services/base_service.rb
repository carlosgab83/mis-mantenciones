class BaseService

  attr_reader :params

  def initialize(params = {})
    self.params = params
  end

  protected

  def execute(sql)
    ActiveRecord::Base.connection.execute(sql)
  end

  def base_host
    case Rails.env
    when 'development'
      'localhost:3000'
    when 'staging'
      'mismantenciones.herokuapp.com'
    when 'production'
      'mismantenciones.com'
    end
  end


  private

  attr_writer :params
end