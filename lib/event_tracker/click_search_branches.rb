module EventTracker
  class ClickSearchBranches < Base
    def initialize(options = {})
      super(options)
      self.attrs.merge!(options[:search_branches_form].brand.to_event_tracker_builder.attributes!) if options[:search_branches_form].brand.present?
      self.attrs.merge!(options[:search_branches_form].model.to_event_tracker_builder.attributes!) if options[:search_branches_form].model.present?
      self.attrs.merge!(patent: options[:search_branches_form].patent) if options[:search_branches_form].patent.present?
      self.attrs.merge!(kms: options[:search_branches_form].kms) if options[:search_branches_form].kms.present?
      self.attrs.merge!(found_branches: options[:found_branches])
      self.attrs.merge!(location_text: options[:search_branches_form].location_text) if options[:search_branches_form].location_text.present?
      self.attrs.merge!(options[:search_branches_form].branch_type.to_event_tracker_builder.attributes!) if options[:search_branches_form].branch_type.present?
    end

    def track
      super("Click search branches")
    end
  end
end