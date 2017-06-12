class UserActivityPublisherJob < ApplicationJob
  queue_as :default

  def perform(user, type, target)
    UserActivityPublisher.new(user: user, type: type, target: target).run(delay: false)
  end
end
