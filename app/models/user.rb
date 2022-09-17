# frozen_string_literal: true

# class responsible by manage user rules
class User
  PROFILES = %w(candidate company professional)

  private_constant :PROFILES

  def self.strong_password?(password)
    checker.is_strong?(password)
  end

  def self.allowed_profile?(profile)
    PROFILES.include?(profile)
  end

  def self.company?(profile)
    profile == 'company'
  end

  def self.professional?(profile)
    profile == 'professional'
  end

  def self.checker
    StrongPassword::StrengthChecker.new
  end

  private_class_method :checker
end
