# frozen_string_literal: true

# class responsible by wrapper user
class UserPresenter
  def self.company?(profile)
    User.company?(profile)
  end

  def self.professional?(profile)
    User.professional?(profile)
  end
end
