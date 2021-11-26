# frozen_string_literal: true

require 'spec_helper'
require_relative '../report_formatter_runner'
require_relative '../report_builder'

describe ReportFormatterRunner do
  let(:gazes) { double('gazes') }
  let(:input_path) { 'data/test_input.json' }
  let(:output_path) { 'data/test_output.json' }
  let(:report) { double('report', input_path: input_path, output_path: output_path) }

  let(:subject) { ReportFormatterRunner.new(report: report, gazes: gazes) }

  let(:input_data) do
    "{\n  \"emission_categories\": [\n { \"id\": 1, \"name\": \"énergie\" }\n ] }"
  end
  let(:formatted_data) do
    { emission_categories: [{ 'énergie': 1, "total_value": 12 },
                            { 'transport': 1, "total_value": 156 }] }
  end
  let(:expected_data) do
    "{\n  \"emission_categories\": [\n    {\n      \"énergie\": 1,\n      "\
    "\"total_value\": 12\n    },\n    {\n      \"transport\": 1,\n      "\
    "\"total_value\": 156\n    }\n  ]\n}"
  end
  let(:file) { double('file', read: input_data) }
  let(:report_builder) { double('report_builder', run: formatted_data) }

  describe '#run' do
    before do
      allow(File).to receive(:open).with(input_path).and_return(file).once
      allow(File).to receive(:open).with(output_path, 'wb').and_call_original
      allow(File).to receive(:open).with(output_path).and_call_original
      allow(ReportBuilder).to receive(:new).and_return(report_builder)
    end

    it 'parse input file' do
      expect(JSON).to receive(:parse).with(input_data)
      subject.run
    end

    it 'calls ReportBuilder' do
      parsed_data = JSON.parse(input_data)
      expect(ReportBuilder).to receive(:new).with(data: parsed_data, gazes: gazes)
      subject.run
    end

    it 'writes output' do
      expect(File.open(output_path).read).to eq(expected_data)
      subject.run
    end
  end
end
