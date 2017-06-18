class CredentialCreation
  def initialize(user:)
    @user = user
  end

  def run
    delete_credentials_if_exceed_limit

    access_token = create_access_token
    credential = user.credentials.create(access_token: access_token)

    return credential
  end

  private
  attr_reader :user

  def delete_credentials_if_exceed_limit
    if user.credentials.count >= 10
      user.credentials.first.delete
    end
  end

  def create_access_token
    Digest::SHA1.hexdigest([Time.now, user.to_json].join)
  end

end
