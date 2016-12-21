class EventTrackerJob < ApplicationJob
  def perform(id, event, attrs)
    $tracker.track(id, event, attrs)
  end
end
