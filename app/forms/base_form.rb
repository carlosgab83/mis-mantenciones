class BaseForm
  attr_reader :params

  def initialize(params)
    self.params = params
  end

  private

  attr_writer :params
end