class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  def slug
    username.downcase.gsub(/[^a-z0-9\s]/, '').gsub(' ', '-')
  end

  def self.find_by_slug(slug_name)
    all.find { |item| item.slug == slug_name }
  end
end
