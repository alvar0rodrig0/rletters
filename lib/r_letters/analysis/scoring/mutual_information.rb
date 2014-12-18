# -*- encoding : utf-8 -*-

module RLetters
  module Analysis
    module Scoring
      # Compute scores on the basis of mutual information
      module MutualInformation
        private

        # A method to compute the score for this pair on the basis of the
        # individual and joint frequencies.
        #
        # The formula for the mutual information present in a given collocation
        # pair is:
        #
        # ```
        # PMI(a, b) = log [ (f(a b) / N) / (f(a) f(b) / N^2) ]
        # (with N the number of single-word tokens)
        # ```
        #
        # @api private
        # @return [Float] the score for this pair
        # @param [Float] f_a the frequency of word A's appearance in blocks
        # @param [Float] f_b the frequency of word B's appearance in blocks
        # @param [Float] f_ab the frequency of joint appearance of A and B in
        #   blocks
        # @param [Float] n the number of blocks
        def score(f_a, f_b, f_ab, n)
          l = (f_ab * n) / (f_a * f_b)
          l = Math.log(l) unless l.abs < 0.001

          l
        end

        # Sort results by the score
        #
        # Higher mutual information scores indicate more significant grams.
        #
        # @api private
        # @param [Array<Array<(String, Float)>>] grams grams in unsorted order
        # @return [Array<Array<(String, Float)>>] grams in sorted order
        def sort_results(grams)
          grams.sort { |a, b| b[1] <=> a[1] }
        end
      end
    end
  end
end