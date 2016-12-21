module EventTracker
  class OpenQuoteManteinanceCoupon < Base
    def initialize(options = {})
      super(options)
      self.attrs.merge!(options[:pauta].to_event_tracker_builder.attributes!)
      self.attrs.merge!(options[:vehicle].to_event_tracker_builder.attributes!)
    end

    def track
      super("Open Quote Manteinance Coupon")
    end
  end
end