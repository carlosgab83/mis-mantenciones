module EventTracker
  class ConfirmManteinanceCoupon < Base
    def initialize(options = {})
      super(options)
      self.attrs.merge!(options[:manteinance_coupon].pauta.to_event_tracker_builder.attributes!)
      self.attrs.merge!(options[:vehicle].to_event_tracker_builder.attributes!)
      self.attrs.merge!(options[:client].to_event_tracker_builder.attributes!) if options[:client]
      self.attrs.merge!(options[:manteinance_coupon].branch.to_event_tracker_builder.attributes!)
      self.attrs.merge!(options[:manteinance_coupon].to_event_tracker_builder.attributes!)
    end

    def track
      super("Confirm Manteinance Coupon")
    end
  end
end