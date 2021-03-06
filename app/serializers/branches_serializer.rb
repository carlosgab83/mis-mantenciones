module BranchesSerializer
  def to_map_builder(branches)
    Jbuilder.new do |json|
      collection = branches.map do |branch|
        [
          branch.id, branch.name, branch.latitude, branch.longitude, branch.branch_type.marker_url,
          branch.interval_between_jumps, branch.branch_type_id, branch.branch_types.map(&:id),
          branch.slug
        ]
      end

      json.array! collection
    end
  end
end
