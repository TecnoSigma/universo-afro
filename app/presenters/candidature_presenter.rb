# frozen_string_literal: true

# class responsible by create vacant job presenter
class CandidaturePresenter
  def self.exceeded_quantity?(candidate)
    Candidature.exceeded_quantity?(candidate)
  end

  def self.candidatures_list(candidate)
    Candidature.list(candidate)
  end
end
