require 'spec_helper'

describe Prettyp::FormatterService do

  let(:formatter_registry) { Prettyp::FormatterRegistry.new }
  let(:language_detection) { Prettyp::LanguageDetectionService.new }

  let(:formatter) { double('formatter', format: 'XML!')}
  let(:formatter_class) { class_double(Prettyp::Formatter::BaseFormatter) }

  subject { described_class.new(formatter_registry: formatter_registry, language_detection: language_detection) }

  context 'from a file' do
    it 'detects a language' do
      expect(language_detection).to receive(:detect_from_file).and_return('xml')
      expect(formatter_registry).to receive(:formatter_for).with('xml').and_return(formatter_class)
      expect(formatter_class).to receive(:new).and_return(formatter)

      expect(subject.format_from_file('no_file')).to eq('XML!')
    end
  end

  context 'using stdin' do
    it 'detects a language' do
      expect($stdin).to receive(:read).and_return('test')
      expect(language_detection).to receive(:detect_from_input).and_return('xml')
      expect(formatter_registry).to receive(:formatter_for).with('xml').and_return(formatter_class)
      expect(formatter_class).to receive(:new).and_return(formatter)

      subject.format_from_stdin
    end
  end
end
