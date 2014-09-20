require 'spec_helper'

describe Prettyp::FormatterRegistry do

  context 'default formatters' do
    subject { described_class.new }

    let(:formatter_class) { Prettyp::Formatter::XML::Xmllint }

    it 'should select a formatter we know' do
      expect(formatter_class).to receive(:check_requirement).and_return(true)
      expect(subject.formatter_for('xml')).to be formatter_class
    end

  end

  context 'providing the formatters' do

    subject { described_class.new(formatters) }

    let(:formatters) { [ formatter ] }
    let(:formatter) { class_double(Prettyp::Formatter::BaseFormatter, check_requirement: check_requirement, languages: ['random'] ) }

    context 'formatter passes check_requirement' do
      let(:check_requirement) { true }

      it 'will select our formatter' do
        expect(subject.formatter_for('random')).to be formatter
      end
    end

    context 'formatter fails check_requirement' do
      let(:check_requirement) { false }

      it 'will not select our formatter' do
        expect(subject.formatter_for('random')).to be nil
      end
    end
  end

end
