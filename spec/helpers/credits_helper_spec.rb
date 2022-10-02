# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CreditsHelper do
  describe '#credit_links' do
    it 'creates credits links list' do
      credit = FactoryBot.create(:credit)

      expected_result = "<ul><li><a href='#{credit.url}' title='#{credit.title}' target='_blank'>#{credit.description}</a></li></ul>"

      result = helper.credit_links

      expect(result).to eq(expected_result)
    end
  end
end
