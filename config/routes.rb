# frozen_string_literal: true

Rails.application.routes.draw do
  draw(:candidate_registers)
  draw(:company_registers)
  draw(:credits)
  draw(:dashboards)
  draw(:logins)
  draw(:professional_registers)
  draw(:register_validations)
  draw(:user_registers)
  draw(:vacant_job_registers)

  draw(:sidekiq)
end
