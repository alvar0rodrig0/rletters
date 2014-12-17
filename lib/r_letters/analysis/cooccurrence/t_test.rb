# -*- encoding : utf-8 -*-

module RLetters
  module Analysis
    module Cooccurrence
      # Analyze cooccurrences using T tests as the significance measure
      class TTest < Base
        include Scoring::TTest
      end
    end
  end
end
