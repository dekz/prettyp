module Prettyp
  class FormatterRegistry

    attr_reader :formatters

    def initialize formatters = Formatter::BaseFormatter.inherited_classes
      determine_formatters formatters
    end

    def formatter_for language
      formatters[format_language_key(language)].first
    end

    private
    def determine_formatters formatters
      our_formatters = Hash.new {|h,k| h[k]=[]}

      formatters.each do |clazz|
        clazz.languages.each { |l| our_formatters[format_language_key(l)] << clazz } if clazz.check_requirement
      end

      @formatters = our_formatters
    end

    def format_language_key l
      l.downcase.to_sym
    end

  end
end
