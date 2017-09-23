module EventTracker
  class OpenAllPromotions < Base
    def initialize(options = {})
      super(options)
      self.attrs.merge!(options[:vehicle].to_event_tracker_builder.attributes!)
      self.attrs.merge!(options[:client].to_event_tracker_builder.attributes!) if options[:client]
      self.attrs.merge!(options[:branch].to_event_tracker_builder.attributes!) if options[:branch]
    end

    def track
      super(event || "Open All Promotions")
    end
  end
end