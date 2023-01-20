# frozen_string_literal: true

# class responsible by mount calendary file
class Calendar
  IP_CLASS = 'PRIVATE'
  FILE_OWNER = 1000
  FILE_GROUP = 1000

  private_constant :IP_CLASS, :FILE_OWNER, :FILE_GROUP

  class << self
    def mount!(summary:, description:, date:)
      raise CalendarFieldError if summary.blank? || description.blank?

      content = content(summary: summary, description: description, date: date)

      File.write(file_path, content)

      File.chown(FILE_OWNER, FILE_GROUP, file_path)

      { status: Rack::Utils::SYMBOL_TO_STATUS_CODE[:created], file_path: file_path.to_s }
    rescue CalendarFieldError => e
      { status: Rack::Utils::SYMBOL_TO_STATUS_CODE[:not_acceptable], error: e.message }
    end

    def file_path
      @file_path ||= Rails.root.join('app', 'storage', 'calendars', filename)
    end

    def filename
      "#{SecureRandom.hex(20)}.ics"
    end

    def calendar_date(date)
      @calendar_date ||= Icalendar::Values::Date.new(date)
    end

    def content(summary:, description:, date:)
      calendar = Icalendar::Calendar.new

      calendar.event do |event|
        event.dtstart     = calendar_date(date)
        event.dtend       = calendar_date(date)
        event.summary     = summary
        event.description = description
        event.ip_class    = IP_CLASS
      end

      calendar.publish

      calendar.to_ical
    end
  end

  private_class_method :file_path, :filename, :content, :calendar_date
end
