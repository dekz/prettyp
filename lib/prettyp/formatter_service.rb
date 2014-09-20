require 'prettyp/language_detection_service'
require 'prettyp/formatter_registry'

module Prettyp
  class FormatError < StandardError; end
  class FormatterService
    include Logger

    def initialize(formatter_registry: FormatterRegistry.new, language_detection: LanguageDetectionService.new)
      @formatter_registry = formatter_registry
      @language_detection = language_detection
    end

    def format_from_file file
      language = language_detection.detect_from_file(file)
      format file, language
    end

    def format_from_stdin
      input = $stdin.read

      language = language_detection.detect_from_input(input)
      with_tempfile input do |f|
        format f, language
      end
    end

    def format_as_language_from_file language, file
      format file, language
    end

    def format_as_language_from_stdin language
      input = $stdin.read

      with_tempfile input do |f|
        format f, language
      end
    end

    private
      attr_reader :formatter_registry, :language_detection

      def format file, language
        formatter = formatter_registry.formatter_for(language)
        raise FormatError, "Cannot determine formatter for #{language} from #{formatter_registry.formatters}" unless formatter
        formatter.new.format(file, language)
      end

      def with_tempfile input, &block
        file = Tempfile.new('prettyp')
        file.write(input)
        begin
          file.rewind
          block.call(file)
        ensure
          file.close
          file.unlink
        end
      end
  end
end

