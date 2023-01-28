# frozen_string_literal: true

# class responsible by mount calendary file
class Calendar
  IP_CLASS = 'PRIVATE'
  FILE_OWNER = 1000
  FILE_GROUP = 1000

  private_constant :IP_CLASS, :FILE_OWNER, :FILE_GROUP

  attr_reader :calendar, :conference_afro_id

  def initialize(conference_afro_id:)
    @conference_afro_id = conference_afro_id
    @calendar = Icalendar::Calendar.new
  end

  def mount!
    raise CalendarFindError unless conference

    File.write(filepath, content)

    File.chown(FILE_OWNER, FILE_GROUP, filepath)

    { status: Rack::Utils::SYMBOL_TO_STATUS_CODE[:created], file_path: filepath.to_s }
  rescue CalendarFindError
    { status: Rack::Utils::SYMBOL_TO_STATUS_CODE[:bad_request] }
  end

  private

  def filepath
    @filepath ||= Rails.root.join('app', 'storage', 'calendars', filename)
  end

  def filename
    "#{SecureRandom.hex(20)}.ics"
  end

  def conference
    @conference ||= Conference.find_by_afro_id(conference_afro_id)
  end

  def calendar_start_date_time
    converted_date_time(conference.start_at)
  end

  def calendar_finish_date_time
    converted_date_time(conference.finish_at)
  end

  def summary
    I18n.t('calendar.summary', company_name: conference.company.name)
  end

  def description
    conference.description
  end

  def organizer
    conference.company.email
  end

  def content
    calendar.event do |event|
      event.organizer   = "mailto:#{organizer}"
      event.dtstart     = calendar_start_date_time
      event.dtend       = calendar_finish_date_time
      event.summary     = summary
      event.description = description
      event.ip_class    = IP_CLASS
    end

    calendar.publish

    calendar.to_ical
  end

  def converted_date_time(date_time)
    parsed_date_time = date_time.strftime('%Y-%m-%d-%H-%M').split('-').map(&:to_i)

    DateTime
      .civil(parsed_date_time[0], parsed_date_time[1], parsed_date_time[2], parsed_date_time[3], parsed_date_time[4])
  end
end
