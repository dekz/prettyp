module Prettyp
  module Formatter
    module HTML
      class Tidy < ::Prettyp::Formatter::BaseFormatter

        def self.languages
          ['HTML']
        end

        def self.executeable; 'tidy'; end

        def self.check_requirement
          !%x|which #{executeable}|.empty?
        end

        def format input, language
          with_file(input) do |file|
            with_tempfile '' do |tmp|
              out = execute_command("#{self.class.executeable} -im #{file.path} -f #{tmp.path} -q",
                                    #on_error: Proc.new { |output| raise FormatError, output })
                                    on_error: Proc.new { })
              out = File.read(file.path)
              out
            end
          end
        end

      end
    end
  end
end

