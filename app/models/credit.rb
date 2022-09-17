# frozen_string_literal: true

# class responsible by manage applications credits (Copyright)
class Credit < ApplicationRecord
  validates :url,
            :description,
            :title,
            presence: { message: I18n.t('messages.errors.required_field') }
end
