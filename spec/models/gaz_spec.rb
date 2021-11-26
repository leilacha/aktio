# frozen_string_literal: true

require 'spec_helper'
require_relative '../../models/gaz'

describe Models::Gaz do
  let(:gaz) { Models::Gaz.new(code: 'co2', can_sum: true) }
  describe '#initialize' do
    it 'initializes attributes' do
      expect(gaz.code).to eq('co2')
      expect(gaz.can_sum).to eq(true)
    end
  end
end
