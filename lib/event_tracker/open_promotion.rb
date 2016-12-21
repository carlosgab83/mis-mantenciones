module EventTracker
  class OpenPromotion < Base
    def initialize(options = {})
      super(options)
      self.attrs.merge!(options[:vehicle].to_event_tracker_builder.attributes!)
      self.attrs.merge!(options[:client].to_event_tracker_builder.attributes!) if options[:client]
      self.attrs.merge!(options[:promotion].to_event_tracker_builder.attributes!)
    end

    def track
      super("Open Promotion")
    end
  end
end