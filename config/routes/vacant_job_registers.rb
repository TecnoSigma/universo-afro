# frozen_string_literal: true

get 'registro-da-vaga-1',            to: 'vacant_job_registers#first_vacant_job'
get 'registro-da-vaga-2',            to: 'vacant_job_registers#second_vacant_job'
post 'store_first_vacant_job_data',  to: 'vacant_job_registers#store_first_vacant_job_data'
post 'store_second_vacant_job_data', to: 'vacant_job_registers#store_second_vacant_job_data'
