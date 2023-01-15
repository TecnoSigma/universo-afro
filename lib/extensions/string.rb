# frozen_string_literal: true

# class responsible by create customized string methods
class String
  ACCENTS = {
    %w[á à â ä ã] => 'a',
    %w[Ã Ä Â À] => 'A',
    %w[é è ê ë] => 'e',
    %w[Ë É È Ê] => 'E',
    %w[í ì î ï] => 'i',
    %w[Î Ì] => 'I',
    %w[ó ò ô ö õ] => 'o',
    %w[Õ Ö Ô Ò Ó] => 'O',
    %w[ú ù û ü] => 'u',
    %w[Ú Û Ù Ü] => 'U',
    ['ç'] => 'c', ['Ç'] => 'C',
    ['ñ'] => 'n', ['Ñ'] => 'N'
  }.freeze

  private_constant :ACCENTS

  def without_accents
    words = self

    ACCENTS.each { |accent, replaced| accent.each { |letter| words = words.gsub(letter, replaced) } }

    words
  end

  def to_resource
    downcase
      .gsub(' ', '-')
      .without_accents
  end
end
