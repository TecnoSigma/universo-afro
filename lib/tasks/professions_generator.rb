# frozen_string_literal: true

require 'csv'

module Tasks
  # Tasks responsible by create professions
  class ProfessionsGenerator
    class << self
      def call!
        clear_tables!
        generate_profession!
      end

      def clear_tables!
        Profession.destroy_all

        ActiveRecord::Base.connection.execute('TRUNCATE TABLE professions RESTART IDENTITY;')

        puts '--- Profession table deleted!'

        true
      end

      def generate_profession!
        CSV.foreach(Rails.root.join('storage', 'professions.csv')) do |profession|
          Profession.create!(name: profession.first)

          puts "-- #{profession.first} created!"
        end

        puts "-- #{Profession.count} professions created!"

        true
      end
    end

    private_class_method :clear_tables!
  end
end
