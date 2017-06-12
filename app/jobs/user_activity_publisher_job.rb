class UserActivityPublisherJob < ApplicationJob
  queue_as :default
  rescue_from 'ActiveJob::DeserializationError', with: -> {
    # no op, rescue carefully...!
  }

  def perform(user, type, target)
    UserActivityPublisher.new(user: user, type: type, target: target).run(delay: false)
  end
end
