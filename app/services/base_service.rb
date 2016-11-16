class BaseService

  attr_reader :params

  def initialize(params)
    self.params = params
  end

  protected

  def execute(sql)
    ActiveRecord::Base.connection.execute(sql)
  end

  private

  attr_writer :params
end