# frozen_string_literal: true

module Financial
  # class responsible by manage session in payment gateway
  class SessionService
    def self.create!
      Financial::SessionAdapter.new(action: :create).fetch
    end
  end
end
