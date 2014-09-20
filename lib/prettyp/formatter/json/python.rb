module Prettyp
  module Formatter
    module JSON
      class Python < ::Prettyp::Formatter::BaseFormatter
        def self.languages
          ['JSON']
        end

        def self.executeable; 'python'; end
        def self.check_requirement
          !%x|which #{executeable}|.empty?
        end

        def format input, language
          with_file(input) do |file|
            out = execute_command("cat #{file.path} | #{self.class.executeable} -m json.tool",
                                  on_error: Proc.new { |output| raise FormatError, output })
          end
        end

      end
    end
  end
end
