module MainFactory
  #TODO: not too sure how to do it with factory girl yet
  def create_recipe
    credential = create(:credential)
    recipe = create(:recipe, user: credential.user)
    return [recipe, credential.access_token]
  end
end