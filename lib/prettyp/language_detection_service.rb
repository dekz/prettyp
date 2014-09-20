require 'linguist'

module Prettyp
  class LanguageDetectionService
    # Our supported languages
    POSSIBLE_LANGUAGE_NAMES = ['XML', 'Ruby', 'JSON', 'JavaScript', 'HTML']

    def detect_from_file file
      file_blob = Linguist::FileBlob.new(file.path)
      language = file_blob.language
      return format_language_key(language.name) if language

      detect_from_input(file_blob.data)
    end

    def detect_from_input input
      classified = Linguist::Classifier.classify(Linguist::Samples::DATA, input, possible).first
      format_language_key(Linguist::Language[classified[0]].name)
    end

    private
    def possible
      @possible_languaes_list ||= POSSIBLE_LANGUAGE_NAMES.map { |n| Linguist::Language.find_by_name(n) }.map(&:name)
    end

    def format_language_key l
      l.downcase.to_sym
    end
  end
end

