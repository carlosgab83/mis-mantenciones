module BranchTypeSerializer
  def to_event_tracker_builder
    Jbuilder.new do |json|
      json.branch_type_id   id
      json.branch_type_name name
    end
  end
end
