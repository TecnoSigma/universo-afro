# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationHelper do
  describe '#textarea_size' do
    it 'returns default textarea size when no pass size' do
      default_size = 15

      result = helper.textarea_size

      expect(result).to eq(default_size)
    end

    it 'returns textarea size when pass size' do
      size  = 50

      result = helper.textarea_size(default_size: size)

      expect(result).to eq(size)
    end
  end

  describe '#boolean_values' do
    it 'returns array of array containing boolean values' do
      result = helper.boolean_values

      expected_result = [['Não', 0], ['Sim', 1]]

      expect(result).to eq(expected_result)
    end
  end

  describe '#convert_date_to_string' do
    it 'returns date_time converted in string' do
      date = '12/12/2024'
      horary = '20:00'
      date_time = "#{date} #{horary}".to_datetime

      result = helper.convert_date_to_string(date_time)

      expected_result = "#{date} - #{horary}"

      expect(result).to eq(expected_result)
    end
  end
end
