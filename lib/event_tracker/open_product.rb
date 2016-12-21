module EventTracker
  class OpenProduct < Base
    def initialize(options = {})
      super(options)
      self.attrs.merge!(options[:vehicle].to_event_tracker_builder.attributes!)
      self.attrs.merge!(options[:client].to_event_tracker_builder.attributes!)
      self.attrs.merge!(options[:product].to_event_tracker_builder.attributes!)
    end

    def track
      super("Open Product")
    end
  end
end