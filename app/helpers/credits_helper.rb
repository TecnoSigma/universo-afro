# frozen_string_literal: true

# Helper responsible by manage credit links
module CreditsHelper
  def credit_links
    result = Credit.all.inject(['<ul>']) do |list, item|
      list << "<li><a href='#{item.url}' title='#{item.title}' target='_blank'>#{item.description}</a></li>"
    end

    (result.join + '</ul>').html_safe
  end
end
