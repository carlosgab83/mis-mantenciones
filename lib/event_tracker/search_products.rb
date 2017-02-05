module EventTracker
  class SearchProducts < Base
    def initialize(options = {})
      super(options)
      self.attrs.merge!(options[:vehicle].to_event_tracker_builder.attributes!)
      self.attrs.merge!(options[:category].to_event_tracker_builder.attributes!) if options[:category]
      self.attrs.merge!(client_search_input: options[:client_search_input].as_json)
    end

    def track
      super("Search Products")
    end
  end
end