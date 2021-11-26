# frozen_string_literal: true

require_relative 'models/report'
require_relative 'models/gaz'
require_relative 'report_formatter_runner'

# Init report
input_path = 'data/input.json'
output_path = 'data/output.json'
report = Models::Report.new(input_path: input_path, output_path: output_path)

# Init gazes
gazes = %w[co2 ch4 n2o co2b ch4b].map do |gaz|
  can_sum = gaz != 'co2b'
  Models::Gaz.new(code: gaz, can_sum: can_sum)
end

# Run formatter
ReportFormatterRunner.new(report: report, gazes: gazes).run
