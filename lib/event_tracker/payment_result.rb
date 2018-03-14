module EventTracker
  class PaymentResult< Base
    def initialize(options = {})
      super(options)
      self.attrs.merge!(options[:vehicle].to_event_tracker_builder.attributes!) if options[:vehicle]
      self.attrs.merge!(options[:payment].order.client.to_event_tracker_builder.attributes!)
      self.attrs.merge!(options[:payment].order.branch.to_event_tracker_builder.attributes!)
      self.attrs.merge!(options[:payment].order.cart.to_event_tracker_builder.attributes!)
      self.attrs.merge!(options[:payment].to_event_tracker_builder.attributes!)
    end

    def track
      super("Payment Result")
    end
  end
end