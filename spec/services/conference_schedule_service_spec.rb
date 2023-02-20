require 'aasm/rspec'
require 'rails_helper'

RSpec.describe ConferenceScheduleService do
  describe 'pass by steps' do
    it 'transits from mounted_calendar_file to finished then no occurs errors ' do
      candidate = FactoryBot.create(:candidate)
      company = FactoryBot.create(:company)
      conference = FactoryBot.create(:conference, company: company, candidate: candidate)

      allow(Calendar)
        .to receive_message_chain(:new, :mount!) { { status: 201,
                                                     file_path: '/universo-afro/app/storage/calendars/1189898fda583b5a5e9d76efc33355710d83e495.ics' } }
      allow(Notifications::SendConferenceInviteJob).to receive(:perform_now) { true }
      allow(FileUtils).to receive(:rm_f) { nil }
      allow(File).to receive(:exist?) { false }

      conference_schedule_service = ConferenceScheduleService.new(conference_afro_id: conference.afro_id)

      result = conference_schedule_service.execute_actions

      expect(result).to eq(true)
    end

    it 'no transits from mounted_calendar_file to sent_conference_notification_to_recruiter then occurs errors ' do
      candidate = FactoryBot.create(:candidate)
      company = FactoryBot.create(:company)
      conference = FactoryBot.create(:conference, company: company, candidate: candidate)

      allow(Calendar).to receive_message_chain(:new, :mount!) { { status: 400, file_path: '' } }

      conference_schedule_service = ConferenceScheduleService.new(conference_afro_id: conference.afro_id)

      expect { conference_schedule_service.execute_actions }.to raise_error(AASM::InvalidTransition)
    end

    it 'no transits from sent_conference_notification_to_recruiter to sent_conference_notification_to_candidate then occurs errors ' do
      candidate = FactoryBot.create(:candidate)
      company = FactoryBot.create(:company)
      conference = FactoryBot.create(:conference, company: company, candidate: candidate)

      allow(Calendar)
        .to receive_message_chain(:new, :mount!) { { status: 201,
                                                     file_path: '/universo-afro/app/storage/calendars/1189898fda583b5a5e9d76efc33355710d83e495.ics' } }
      allow(Notifications::SendConferenceInviteJob).to receive(:perform_now) { false }

      conference_schedule_service = ConferenceScheduleService.new(conference_afro_id: conference.afro_id)

      expect { conference_schedule_service.execute_actions }.to raise_error(AASM::InvalidTransition)
    end

    it 'no transits from sent_conference_notification_to_candidate to deleted_calendar_file then occurs errors ' do
      candidate = FactoryBot.create(:candidate)
      company = FactoryBot.create(:company)
      conference = FactoryBot.create(:conference, company: company, candidate: candidate)

      allow(Calendar)
        .to receive_message_chain(:new, :mount!) { { status: 201,
                                                     file_path: '/universo-afro/app/storage/calendars/1189898fda583b5a5e9d76efc33355710d83e495.ics' } }
      allow(Notifications::SendConferenceInviteJob).to receive(:perform_now) { false }

      conference_schedule_service = ConferenceScheduleService.new(conference_afro_id: conference.afro_id)

      expect { conference_schedule_service.execute_actions }.to raise_error(AASM::InvalidTransition)
    end

    it 'no transits from deleted_calendar_file to changed_conference_status then occurs errors ' do
      candidate = FactoryBot.create(:candidate)
      company = FactoryBot.create(:company)
      conference = FactoryBot.create(:conference, company: company, candidate: candidate)

      allow(Calendar)
        .to receive_message_chain(:new, :mount!) { { status: 201,
                                                     file_path: '/universo-afro/app/storage/calendars/1189898fda583b5a5e9d76efc33355710d83e495.ics' } }
      allow(Notifications::SendConferenceInviteJob).to receive(:perform_now) { true }
      allow(FileUtils).to receive(:rm_f) { nil }
      allow(File).to receive(:exist?) { true }

      conference_schedule_service = ConferenceScheduleService.new(conference_afro_id: conference.afro_id)

      expect { conference_schedule_service.execute_actions }.to raise_error(AASM::InvalidTransition)
    end
  end
end
