module EventTracker
  class FrontendTracking < Base
    def initialize(options = {})
      super(options)
      self.attrs.merge!(options[:data])
      self.attrs.merge!(options[:client].to_event_tracker_builder.attributes!) if options[:client]
    end

    def track
      super(event || 'Generic Event')
    end
  end
end