require 'tempfile'

module Prettyp
  module Formatter
    class FormatError < StandardError; end
    class Unimplemented < StandardError; end

    class BaseFormatter
      include Logger

      def self.inherited clazz
        @inherited_classes ||= []
        @inherited_classes << clazz
      end

      def self.inherited_classes
        @inherited_classes
      end

      def self.check_requirement
        raise Unimplemented 'requirement'
      end

      def self.languages
        []
      end

      def check_requirement
        self.class.check_requirement
      end

      def format input, language
        raise Unimplemented 'format'
      end

      protected
      def execute_command command, on_error: nil, on_success: nil
        logger.debug command

        output = `#{command} 2>&1 `
        success = !execute_error?

        on_error.call(output) if !success && on_error
        on_success.call(output) if success and on_success

        output
      end

      def execute_error?
        $? != 0
      end

      def with_file input, &block
        return block.call(input) if input.is_a?(File) || input.is_a?(Tempfile)
        with_tempfile(input, &block)
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
end

