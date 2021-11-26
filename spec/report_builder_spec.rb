# frozen_string_literal: true

require 'spec_helper'
require_relative '../report_builder'

describe ReportBuilder do
  let(:gaz1) { double('gaz1', code: 'co2', can_sum: true) }
  let(:gaz2) { double('gaz2', code: 'co2b', can_sum: false) }
  let(:gazes) { [gaz1, gaz2] }
  let(:data) do
    { 'emission_categories' => [{ 'id' => 2, 'name' => 'transports' }, { 'id' => 4, 'name' => 'déchets' }],
      'emission_factors' =>
  [
    { 'id' => 2, 'description' => 'diesel routier', 'emission_categorie_id' => 2, 'unit_1' => 'tonne', 'unit_2' => 'km',
      'value_co2' => 0.124, 'value_co2b' => 0.86 },
    { 'id' => 3, 'description' => 'TGV', 'emission_categorie_id' => 2, 'unit_1' => 'passager', 'unit_2' => 'km',
      'value_co2' => 0.00174, 'value_co2b' => 0.002 },
    { 'id' => 4, 'description' => 'ordinateur portable', 'emission_categorie_id' => 3, 'unit_1' => 'unité',
      'unit_2' => nil, 'value_co2' => 156.0, 'value_co2b' => 123 }
  ],
      'activity_data' =>
  [{ 'id' => 1, 'emission_factor_id' => 1, 'area_id' => 1, 'quantity_1' => 5500, 'quantity_2' => nil },
   { 'id' => 2, 'emission_factor_id' => 2, 'area_id' => 1, 'quantity_1' => 1000, 'quantity_2' => 6000 },
   { 'id' => 3, 'emission_factor_id' => 3, 'area_id' => 1, 'quantity_1' => 4, 'quantity_2' => 2000 },
   { 'id' => 4, 'emission_factor_id' => 4, 'area_id' => 1, 'quantity_1' => 20, 'quantity_2' => nil },
   { 'id' => 7, 'emission_factor_id' => 1, 'area_id' => 2, 'quantity_1' => 3000, 'quantity_2' => nil },
   { 'id' => 8, 'emission_factor_id' => 2, 'area_id' => 2, 'quantity_1' => 500, 'quantity_2' => 3000 },
   { 'id' => 10, 'emission_factor_id' => 4, 'area_id' => 2, 'quantity_1' => 30, 'quantity_2' => nil }],
      'sites' => [{ 'id' => 1, 'name' => 'entrepôt - Limoges' }] }
  end

  let(:expected_data) do
    [{ 'entrepôt - Limoges' =>
   [{ 'transports' =>
      { emissions: [{ :activity_datum_id => 2,
                      :description => 'diesel routier',
                      :id => 2,
                      :total_value => 744_000.0,
                      :unit => 'kgCO2e/tonne.km',
                      'value_co2' => 744_000.0,
                      'value_co2b' => 5_160_000.0 },
                    { :activity_datum_id => 3,
                      :description => 'TGV',
                      :id => 3,
                      :total_value => 13.92,
                      :unit => 'kgCO2e/passager.km',
                      'value_co2' => 13.92,
                      'value_co2b' => 16.0 }],
        total_value: 744_013.92 } },
    { 'déchets' => { emissions: [], total_value: 0.0 } }] }]
  end

  let(:subject) { ReportBuilder.new(data: data, gazes: gazes) }

  describe '#run' do
    it 'builds the formatted report' do
      expect(subject.run).to eq(expected_data)
    end
  end
end
