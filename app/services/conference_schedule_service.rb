# frozen_string_literal: true

# class responsible by schedule conferences
class ConferenceScheduleService
  include AASM

  aasm do
    state :mounted_calendar_file, initial: true
    state :sent_conference_notification_to_recruiter
    state :sent_conference_notification_to_candidate
    state :deleted_calendar_file
    state :changed_conference_status
    state :finished

    event :mount_calendar_file do
      transitions from: :mounted_calendar_file, to: :sent_conference_notification_to_recruiter,
                  if: :mount_calendar_file!
    end

    event :send_conference_notification_to_recruiter do
      transitions from: :sent_conference_notification_to_recruiter, to: :sent_conference_notification_to_candidate,
                  if: :send_conference_notification_to_recruiter!
    end

    event :send_conference_notification_to_candidate do
      transitions from: :sent_conference_notification_to_candidate, to: :deleted_calendar_file,
                  if: :send_conference_notification_to_candidate!
    end

    event :delete_calendar_file do
      transitions from: :deleted_calendar_file, to: :changed_conference_status,
                  if: :delete_calendar_file!
    end

    event :change_conference_status do
      transitions from: :changed_conference_status, to: :finished, if: :change_conference_status!
    end
  end

  attr_reader :conference_afro_id, :filepath

  def initialize(conference_afro_id:)
    @conference_afro_id = conference_afro_id
  end

  def execute_actions
    mount_calendar_file                       if mounted_calendar_file?
    send_conference_notification_to_recruiter if sent_conference_notification_to_recruiter?
    send_conference_notification_to_candidate if sent_conference_notification_to_candidate?
    delete_calendar_file                      if deleted_calendar_file?
    change_conference_status                  if changed_conference_status?
  end

  def mount_calendar_file!
    calendar_data = Calendar.new(conference_afro_id: conference.afro_id).mount!

    @filepath = calendar_data[:file_path]

    calendar_data[:status] == Rack::Utils::SYMBOL_TO_STATUS_CODE[:created]
  end

  def send_conference_notification_to_recruiter!
    Notifications::SendConferenceInviteService
      .new(name: candidate_name, email: company_email, filepath: @filepath, datetime: start_at, recruiter: true)
      .deliver!
  end

  def send_conference_notification_to_candidate!
    Notifications::SendConferenceInviteService
      .new(name: company_name, email: candidate_email, filepath: @filepath, datetime: start_at)
      .deliver!
  end

  def delete_calendar_file!
    FileUtils.rm_f(@filepath)

    !File.exist?(@filepath)
  end

  def change_conference_status
    new_status = Statuses::CONFERENCE.key(2).to_s

    conference.update!(
      status: new_status,
      date: conference.start_at.strftime('%d/%m/%Y'),
      horary: conference.start_at.strftime('%H:%M')
    )
  rescue StandardError
    binding.pry
    false
  end

  def candidate_name
    conference.candidate.first_name
  end

  def candidate_email
    conference.candidate.email
  end

  def company_email
    conference.company.email
  end

  def company_name
    conference.company.name
  end

  def conference
    @conference ||= Conference.find_by_afro_id(conference_afro_id)
  end

  def start_at
    @start_at ||= conference.start_at.strftime('%d/%m/%Y - %H:%Mhs')
  end
end
