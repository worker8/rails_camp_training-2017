class CommentActivity < UserActivity
  delegate :title, to: :recipe, prefix: true

  def recipe
    target.recipe
  end

  def body
    target.text
  end
end
