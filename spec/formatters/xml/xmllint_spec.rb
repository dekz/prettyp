require 'spec_helper'

describe Prettyp::Formatter::XML::Xmllint do

  subject { described_class.new }

  it 'can be used' do
    expect(subject.check_requirement).to be true
  end

  context 'format' do

    let(:format) { subject.format(input, :xml) }

    context 'invalid input' do
      let(:input) { 'abcd' }
      it 'raises a format error' do
        expect{ format }.to raise_error Prettyp::Formatter::FormatError
      end
    end

    context 'valid input' do
      let(:input) do
%|<?xml version="1.0" encoding="UTF-8"?> <note> <to>Tove</to> <from>Jani</from> <heading>Reminder</heading> <body>Don't forget me this weekend!</body> </note>|
      end

      it 'returns a formatted document' do
        expect(format.split("\n").size).to be >= 2
      end
    end

  end
end
