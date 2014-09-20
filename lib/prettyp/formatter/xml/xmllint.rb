module Prettyp
  module Formatter
    module XML
      class Xmllint < ::Prettyp::Formatter::BaseFormatter

        def self.languages
          [:xml, :html]
        end

        def self.executeable; 'xmllint'; end
        def self.check_requirement
          !%x|which #{executeable}|.empty?
        end

        def format input, language
          extra_opts = '--html' if language.eql? :html
          with_file(input) do |file|
            out = execute_command("cat #{file.path} | #{self.class.executeable} --format #{extra_opts} -",
                                  on_error: Proc.new { |output| raise FormatError, output })
          end
        end

      end
    end
  end
end

