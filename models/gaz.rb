# frozen_string_literal: true

class Models
  # class for Gaz model
  class Gaz
    attr_reader :code, :can_sum

    def initialize(code:, can_sum:)
      @code = code
      @can_sum = can_sum
    end
  end
end
