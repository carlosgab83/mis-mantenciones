module EventTracker
  class Base
    attr_reader :attrs, :id, :controller, :event
    attr_writer :attrs, :id, :controller, :event

    def initialize(options = {})
      self.attrs ||= {}
      self.controller = options[:controller]
      set_base_attrs(controller)
      self.event = options[:event]
    end

    def set_base_attrs(controller)
      self.id = controller.session[:client].try(:id) || controller.session.id
      self.attrs.merge!(
        {
          enviroment: Rails.env,
          http_referer: controller.request.env["HTTP_REFERER"],
          http_origin: controller.request.env["HTTP_ORIGIN"],
          remote_addr: controller.request.env["REMOTE_ADDR"],
          path_info: controller.request.env["PATH_INFO"]
        }
      )
    end

    def track(event)
      return if Rails.env.development?
      EventTrackerJob.perform_later(id, event, attrs)
    end
  end
end