# frozen_string_literal: true

# class responsible by control credits
class CreditsController < ApplicationController
  def index
    @credits = Credit.all
  end
end
