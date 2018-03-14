module EventTracker
  class ClickToPay < Base
    def initialize(options = {})
      super(options)
      self.attrs.merge!(options[:vehicle].to_event_tracker_builder.attributes!)
      self.attrs.merge!(payment_type: options[:payment_type])
      self.attrs.merge!(pick_up_branch: options[:order].client.region)
      self.attrs.merge!(options[:order].client.to_event_tracker_builder.attributes!)
      self.attrs.merge!(options[:order].branch.to_event_tracker_builder.attributes!)
      self.attrs.merge!(options[:order].cart.to_event_tracker_builder.attributes!)
      self.attrs.merge!(options[:order].to_event_tracker_builder.attributes!)
    end

    def track
      super("Click Pay")
    end
  end
end