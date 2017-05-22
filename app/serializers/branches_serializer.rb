module BranchesSerializer
  def to_map_builder(branches)
    Jbuilder.new do |json|
      collection = branches.map do |branch|
        [branch.id, branch.name, branch.latitude, branch.longitude, branch.branch_type.marker_url]
      end

      json.array! collection
    end
  end
end
