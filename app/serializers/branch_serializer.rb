module BranchSerializer
  def to_event_tracker_builder
    Jbuilder.new do |json|
      json.branch_id           id
      json.branch_name         name
    end
  end
end
