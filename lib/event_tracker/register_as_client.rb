module EventTracker
  class RegisterAsClient < Base
    def initialize(options = {})
      super(options)
      self.attrs.merge!(options[:vehicle].to_event_tracker_builder.attributes!)
      self.attrs.merge!(options[:client].to_event_tracker_builder.attributes!) if options[:client]
      self.attrs.merge!({by: options[:by]})
    end

    def track
      # Link previous session id with recently created client id
      EventTrackerAliasJob.perform_later(attrs[:client_id], controller.session.id)
      super("Register as Client")
    end
  end
end