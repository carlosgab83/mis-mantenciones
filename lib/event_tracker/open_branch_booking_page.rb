module EventTracker
  class OpenBranchBookingPage < Base
    def initialize(options = {})
      super(options)
      self.attrs.merge!(options[:manteinance_coupon].pauta.to_event_tracker_builder.attributes!)
      self.attrs.merge!(options[:vehicle].to_event_tracker_builder.attributes!)
      self.attrs.merge!(options[:client].to_event_tracker_builder.attributes!) if options[:client]
      self.attrs.merge!(options[:manteinance_coupon].branch.to_event_tracker_builder.attributes!)
      self.attrs.merge!({booking_url: options[:manteinance_coupon].branch.booking_url})
      self.attrs.merge!(options[:manteinance_coupon].to_event_tracker_builder.attributes!)
    end

    def track
      super("Open Branch Booking Page")
    end
  end
end