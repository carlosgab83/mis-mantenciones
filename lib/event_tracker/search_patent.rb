module EventTracker
  class SearchPatent < Base
    def initialize(options = {})
      super(options)
      self.attrs.merge!(options[:pauta].to_event_tracker_builder.attributes!)
      self.attrs.merge!(options[:vehicle].to_event_tracker_builder.attributes!)
      self.attrs.merge!(Promotion.to_promotions_carousel_event_tracker_builder(options[:promotions]).attributes!)
      self.attrs.merge!(Product.to_products_carousel_event_tracker_builder(options[:products]).attributes!)
      self.attrs.merge!(options[:client].to_event_tracker_builder.attributes!) if options[:client]
    end

    def track
      super("Search Patent")
    end
  end
end