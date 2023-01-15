# frozen_string_literal: true

# class responsible by rescue authorized candidate errors
class FindCandidateError < StandardError
  def initialize(message = I18n.t('messages.errors.candidate_not_found'))
    super
  end
end
