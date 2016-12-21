module EventTracker
  class FilterPromotions < Base
    def initialize(options = {})
      super(options)
      self.attrs.merge!(options[:vehicle].to_event_tracker_builder.attributes!)
      self.attrs.merge!(options[:client].to_event_tracker_builder.attributes!)
      self.attrs.merge!(options[:category].to_event_tracker_builder.attributes!)
    end

    def track
      super("Filter Promotions")
    end
  end
end