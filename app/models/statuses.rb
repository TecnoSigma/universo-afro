# frozen_string_literal: true

# Class responsible by manage statuses

class Statuses
  CANDIDATE = { pendent: 1, activated: 2, deactivated: 3, cancelled: 4 }.freeze
  PROFESSIONAL = { pendent: 1, activated: 2, deactivated: 3, cancelled: 4 }.freeze
  COMPANY = { pendent: 1, activated: 2, deactivated: 3, cancelled: 4 }.freeze
  VACANT_JOB = { opened: 1, closed: 2, cancelled: 3 }.freeze
  CONFERENCE = { pendent: 1, accepted: 2, refused: 3, cancelled: 4 }.freeze
  PLAN = { activated: 1, deactivated: 2, expired: 3 }.freeze
end
