# frozen_string_literal: true

# class responsible by schedule conferences
class ConferenceScheduleService
  include AASM

  aasm do
    state :mounted_calendar_file, initial: true
    state :sent_conference_notification
    state :deleted_calendar_file
    state :finished

    event :mount_calendar_file do
      transitions from: :mounted_calendar_file,
                  to: :sent_conference_notification,
                  if: :mount_calendar_file!
    end

    event :send_conference_notification do
      transitions from: :sent_conference_notification,
                  to: :deleted_calendar_file,
                  if: :send_conference_notification!
    end

    event :delete_calendar_file do
      transitions from: :deleted_calendar_file,
                  to: :finished,
                  if: :delete_calendar_file!
    end
  end

  attr_reader :candidature

  def initialize(candidature)
    @candidature = candidature
  end

  def execute_actions
    mount_calendar_file          if mounted_calendar_file?
    send_conference_notification if sent_conference_notification?
    delete_calendar_file         if deleted_calendar_file?
  end

  def mount_calendar_file!
    calendar_data = Calendar.new(conference_afro_id: conference.afro_id).mount!

    @path_file = calendar_data[:file_path]

    calendar_data[:status] == Rack::Utils::SYMBOL_TO_STATUS_CODE[:created]
  end

  def send_conference_notification!
    true
  end

  def delete_calendar_file!
    true
  end
end
