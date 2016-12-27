module EventTracker
  class OpenBranchesProductUrl < Base
    def initialize(options = {})
      super(options)
      self.attrs.merge!(options[:vehicle].to_event_tracker_builder.attributes!)
      self.attrs.merge!(options[:client].to_event_tracker_builder.attributes!) if options[:client]
      self.attrs.merge!(options[:product].to_event_tracker_builder.attributes!) if options[:product]
      self.attrs.merge!(options[:branch].to_event_tracker_builder.attributes!) if options[:branch]
      self.attrs.merge!({url: options[:url]})
    end

    def track
      # Link previous session id with recently created client id
      EventTrackerAliasJob.perform_later(attrs[:client_id], controller.session.id)
      super("Open Branch Product Url")
    end
  end
end