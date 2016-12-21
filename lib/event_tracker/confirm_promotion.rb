module EventTracker
  class ConfirmPromotion < Base
    def initialize(options = {})
      super(options)
      self.attrs.merge!(options[:vehicle].to_event_tracker_builder.attributes!)
      self.attrs.merge!(options[:client].to_event_tracker_builder.attributes!)
      self.attrs.merge!(options[:coupon].to_event_tracker_builder.attributes!)
    end

    def track
      super("Confirm Promotion")
    end
  end
end