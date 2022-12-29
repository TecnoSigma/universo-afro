# frozen_string_literal: true

# class responsible by create vacant job presenter
class CandidaturePresenter
  def self.exceeded_quantity?(candidate)
    Candidature.exceeded_quantity?(candidate)
  end
end
