class EventTrackerAliasJob < ApplicationJob
  def perform(client_id, session_id)
    $tracker.alias(client_id, session_id)
  end
end
