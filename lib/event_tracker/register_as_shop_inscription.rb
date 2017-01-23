module EventTracker
  class RegisterAsShopInscription < Base
    def initialize(options = {})
      super(options)
      self.attrs.merge!(options[:shop_inscription].to_event_tracker_builder.attributes!)
    end

    def track
      super("Register as ShopInscription")
    end
  end
end