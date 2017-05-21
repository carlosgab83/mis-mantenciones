module EventTracker
  class ClickSearchWithoutLocation < Base
    def initialize(options = {})
      super(options)
    end

    def track
      super("Click search without location")
    end
  end
end