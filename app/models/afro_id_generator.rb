# frozen_string_literal: true

# module responsible by create afro ID
module AfroIdGenerator
  def self.included(klass)
    klass.before_validation(on: :create) { generate_afro_id! }
  end

  private

  def generate_afro_id!
    self.afro_id = SecureRandom.hex(10)
  end
end
