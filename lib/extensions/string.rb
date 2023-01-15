# frozen_string_literal: true

# class responsible by create customized string methods
class String
  ACCENTS = {
      ['á','à','â','ä','ã'] => 'a',
      ['Ã','Ä','Â','À'] => 'A',
      ['é','è','ê','ë'] => 'e',
      ['Ë','É','È','Ê'] => 'E',
      ['í','ì','î','ï'] => 'i',
      ['Î','Ì'] => 'I',
      ['ó','ò','ô','ö','õ'] => 'o',
      ['Õ','Ö','Ô','Ò','Ó'] => 'O',
      ['ú','ù','û','ü'] => 'u',
      ['Ú','Û','Ù','Ü'] => 'U',
      ['ç'] => 'c', ['Ç'] => 'C',
      ['ñ'] => 'n', ['Ñ'] => 'N'
    }

  private_constant :ACCENTS

  def without_accents
    words = self

    ACCENTS.each { |accent, replaced| accent.each { |letter| words = words.gsub(letter, replaced) } }

    words
  end

  def to_resource
    downcase
      .gsub(' ' , '-')
      .without_accents
  end
end
