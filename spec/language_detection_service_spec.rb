require 'spec_helper'

describe Prettyp::LanguageDetectionService do

  before(:each) do
    FakeFS.activate!
    FileUtils.mkdir '/tmp'
  end

  after(:each) do
    FakeFS::FileSystem.clear
    FakeFS.deactivate!
  end

  subject { described_class.new }

  let(:file) do
    File.open(file_name, 'w+') { |f| f.write file_contents }
    f = File.new(file_name)
  end

  context 'xml' do
    let(:file_contents) { %|<?xml version="1.0" encoding="UTF-8"?> <note> <to>Tove</to> <from>Jani</from> <heading>Reminder</heading> <body>Don't forget me this weekend!</body> </note>| }

    context 'file extension' do
      let(:file_name) { '/tmp/prettyp.xml' }
      it 'should detect the file as XML' do
        expect(subject.detect_from_file(file)).to eq(:xml)
      end
    end

    context 'no file extension' do
      let(:file_name) { '/tmp/prettyp' }
      it 'should detect the file as XML' do
        expect(subject.detect_from_file(file)).to eq(:xml)
      end
    end
  end

  context 'json' do
    let(:file_contents) { %|{"menu": { "id": "file", "value": "File", "popup": { "menuitem": [ {"value": "New", "onclick": "CreateNewDoc()"}, {"value": "Open", "onclick": "OpenDoc()"}, {"value": "Close", "onclick": "CloseDoc()"} ] } }}| }

    context 'file extension' do
      let(:file_name) { '/tmp/prettyp.json' }

      it 'should detect the file as JSON' do
        expect(subject.detect_from_file(file)).to eq(:json)
      end
    end

    context 'no file extension' do
      let(:file_name) { '/tmp/prettyp' }

      it 'should detect the file as JSON' do
        expect(subject.detect_from_file(file)).to eq(:json)
      end
    end

  end

end
