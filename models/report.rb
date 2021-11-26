# frozen_string_literal: true

class Models
  # class for Report model
  class Report
    attr_reader :input_path, :output_path

    def initialize(input_path:, output_path:)
      @input_path = input_path
      @output_path = output_path
    end
  end
end
