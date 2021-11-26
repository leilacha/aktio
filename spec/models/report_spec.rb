# frozen_string_literal: true

require 'spec_helper'
require_relative '../../models/report'

describe Models::Report do
  let(:report) do
    Models::Report.new(input_path: 'data/input.csv', output_path: 'data/output.csv')
  end
  describe '#initialize' do
    it 'initializes attributes' do
      expect(report.input_path).to eq('data/input.csv')
      expect(report.output_path).to eq('data/output.csv')
    end
  end
end
