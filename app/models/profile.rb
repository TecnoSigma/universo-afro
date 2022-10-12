# frozen_string_literal: true

# Class responsible by manage profiles
class Profile
  PROFILES = %w[candidate company professional].freeze

  def self.list
    PROFILES.inject([]) { |list, item| list << [I18n.t("profiles.#{item}"), item] }
  end
end
