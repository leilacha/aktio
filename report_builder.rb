# frozen_string_literal: true

require 'json'

# Builds the input data into the output desired format
class ReportBuilder
  def initialize(data:, gazes:)
    @data = data
    @gazes = gazes
  end

  def run
    @data['sites'].map do |site|
      { site['name'] => build_site_information(site) }
    end
  end

  private

  def build_site_information(site)
    @data['emission_categories'].map do |category|
      { category['name'] => build_category_information(category, site) }
    end
  end

  def build_category_information(category, site)
    factors = @data['emission_factors'].select { |factor| factor['emission_categorie_id'] == category['id'] }
    emissions_summary = build_emissions_summary(factors, site)
    total_value = 0.0
    emissions_summary.each { |factor| total_value += factor[:total_value] }
    { total_value: total_value,
      emissions: emissions_summary }
  end

  def build_emissions_summary(factors, site)
    factors.map do |factor|
      build_factor_summary(factor, site)
    end
  end

  def build_factor_summary(factor, site)
    activity = fetch_activity(factor, site)
    ratio = calculate_ratio(activity)
    sums = calculate_sums(ratio, factor)
    {
      id: factor['id'],
      description: factor['description'],
      unit: build_unit(factor),
      activity_datum_id: activity['id']
    }.merge(sums)
  end

  def calculate_sums(ratio, factor)
    result = {}
    @gazes.each do |gaz|
      result["value_#{gaz.code}"] = calculate_value(gaz.code, ratio, factor)
    end
    total_value = 0.0
    @gazes.each { |gaz| total_value += result["value_#{gaz.code}"].to_f if gaz.can_sum }
    result[:total_value] = total_value
    result
  end

  def calculate_ratio(activity)
    ratio = activity['quantity_1']
    ratio *= activity['quantity_2'] if activity['quantity_2']
    ratio
  end

  def calculate_value(gaz_code, ratio, factor)
    return nil unless factor["value_#{gaz_code}"]

    result = factor["value_#{gaz_code}"] * ratio
    result.round(2)
  end

  def fetch_activity(factor, site)
    @data['activity_data'].select do |activity|
      activity['emission_factor_id'] == factor['id'] && activity['area_id'] == site['id']
    end.last
  end

  def build_unit(factor)
    "kgCO2e/#{[factor['unit_1'], factor['unit_2']].compact.join('.')}"
  end
end
