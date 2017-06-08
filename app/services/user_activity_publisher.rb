class UserActivityPublisher
  def initialize(user:, type:, target:)
    @user = user
    @type = type
    @target = target
  end

  def run
    return if user.followers.none?

    activity = get_activity
    if activity.new_record?
      begin
        activity.save
      rescue ActiveRecord::RecordNotUnique
        return
      end
      publish_activity(activity)
    end
  end

  private
  attr_reader :user, :target, :type

  ACTIVITY_MAP = {
    bookmark: BookmarkActivity
  }.freeze

  def get_activity
    activity_class.find_or_initialize_by(
      user: user,
      target: target
    )
  rescue ActiveRecord::RecordNotUnique
    retry
  end

  def activity_class
    ACTIVITY_MAP.fetch(type.to_sym)
  end

  def publish_activity(activity)
    user.followers.find_each do |follower| # find_each limit to 1000, justin bieber problem
      FeedItem.create(user: follower, user_activity: activity)
    end
  end
end
