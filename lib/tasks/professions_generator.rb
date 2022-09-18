# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'

module Tasks
  class ProfessionsGenerator
    class << self
      ALPHABET = %w(a b c d e f g h i j k l m n o p q r s t u v w x y z)

      private_constant :ALPHABET

      def call!
        clear_tables!
        generate_profession!
      end

      def clear_tables!
        Profession.destroy_all

        ActiveRecord::Base.connection.execute("TRUNCATE TABLE professions RESTART IDENTITY;")

        puts "--- Profession table deleted!"

        true
      end

      def generate_profession!
        professions = []

        ALPHABET.each do |letter|
          professions  << get_professions(letter)

          puts "--- Professions with #{letter} collected!"
        end

         professions.flatten.uniq.sort.each do |profession|
          Profession.create!(name: profession)

          puts "--- Profession of #{profession} created!"
        end

        puts "-- #{Profession.count} professions created!"

        true
      end

      def get_professions(letter)
        doc = Nokogiri::HTML(URI.open("https://www.catho.com.br/profissoes/cargo/#{letter}/"))

        JSON
          .parse(doc.children.children.children.children.last)['props']['pageProps']['professions']
          .pluck('name')
      rescue OpenURI::HTTPError
        []
      end
    end

    private_class_method :clear_tables!,
                         :generate_profession!,
                         :get_professions
  end
end
