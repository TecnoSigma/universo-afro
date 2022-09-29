# frozen_string_literal: true

# class responsible by manage models
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
