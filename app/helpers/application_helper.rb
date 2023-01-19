# frozen_string_literal: true

# Helper responsible by manage views
module ApplicationHelper
  def textarea_size(default_size: 15)
    default_size
  end

  def boolean_values
    [I18n.t('booleans.false'), I18n.t('booleans.true')]
  end

  def convert_date_to_string(date_time)
    date_time.strftime('%d/%m/%Y - %H:%M')
  end
end
