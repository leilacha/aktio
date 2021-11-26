# frozen_string_literal: true

require 'json'
require_relative 'report_builder'

# Reads input and writes reformatted output data
class ReportFormatterRunner
  def initialize(report:, gazes:)
    @report = report
    @gazes = gazes
  end

  def run
    raw_data = read_report
    clean_data = data_reformat(raw_data)
    write_report(clean_data)
  end

  private

  def data_reformat(data)
    ReportBuilder.new(data: data, gazes: @gazes).run
  end

  def read_report
    input_data = File.open(@report.input_path).read
    JSON.parse(input_data)
  end

  def write_report(data)
    pretty_json = JSON.pretty_generate(data)
    File.open(@report.output_path, 'wb') { |file| file.write(pretty_json) }
  end
end
