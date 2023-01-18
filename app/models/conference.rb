class Conference < ApplicationRecord
  validates :date,
            :horary,
            presence: { message: I18n.t('messages.errors.required_field') }

  belongs_to :candidate
  belongs_to :company

  enum status: Statuses::CONFERENCE

  before_validation(on: :create) { generate_afro_id! }

  private

  def generate_afro_id!
    self.afro_id = SecureRandom.hex(10)
  end
end
