module EventTracker
  class ClickSearchWithoutPatent < Base
    def initialize(options = {})
      super(options)
    end

    def track
      super("Click search without patent")
    end
  end
end