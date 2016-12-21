module EventTracker
  class OpenAllPromotions < Base
    def initialize(options = {})
      super(options)
      self.attrs.merge!(options[:vehicle].to_event_tracker_builder.attributes!)
      self.attrs.merge!(options[:client].to_event_tracker_builder.attributes!)
    end

    def track
      super("Open All Promotions")
    end
  end
end