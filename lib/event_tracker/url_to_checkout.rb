module EventTracker
  class UrlToCheckout < Base
    def initialize(options = {})
      super(options)
      self.attrs.merge!(options[:vehicle].to_event_tracker_builder.attributes!)
      self.attrs.merge!(options[:client].to_event_tracker_builder.attributes!) if options[:client]
      self.attrs.merge!(options[:product].to_event_tracker_builder.attributes!) if options[:product]
      self.attrs.merge!(options[:promotion].to_event_tracker_builder.attributes!) if options[:promotion]
      self.attrs.merge!(options[:branch].to_event_tracker_builder.attributes!) if options[:branch]
    end

    def track
      super("Url to Checkout")
    end
  end
end