module ApplicationHelper
  def gravatar(email, size = 50)
    url = "http://www.gravatar.com/avatar/"
    hash = Digest::MD5.hexdigest(email)
    return "#{url}#{hash}?size=#{size}"
  end
end
