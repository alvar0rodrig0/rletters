# -*- encoding : utf-8 -*-

module RLetters
  module Analysis
    module Cooccurrence
      # Analyze coocurrences using mutual information as the significance
      # measure
      class MutualInformation < Base
        # Perform mutual information analysis
        #
        # The formula for the mutual information present in a given
        # cooccurrence pair is:
        #
        # ```
        # PMI(a, b) = log [ (f(a ^ b) * N) / (f(a) * f(b)) ]
        # (with N the number of blocks, f(a) the number of blocks containing a)
        # ```
        #
        # @api public
        # @return [Array<Array(String, Float)>] a set of words and their
        #   associated significance values, sorted in order of significance
        #   (most significant first)
        # @example Run a log-likelihood analysis of a dataset
        #   an = RLetters::Analysis::Cooccurrence::MutualInformation.new(
        #     d, 30, 'evolutionary')
        #   result = an.call
        def call
          analyzer = get_analyzer
          blocks = analyzer.blocks
          total = analyzer.word_list.size
          n = analyzer.blocks.size.to_f

          # Nuke all zero elements in the blocks to make the rest of this much
          # faster
          blocks.each do |b|
            b.reject! { |k, v| v == 0 }
          end

          f_a = blocks.count { |b| b[@word] }

          # Notably, if the requested word doesn't appear anywhere at all, we
          # should just quit while we're ahead
          if f_a == 0
            @progress.call(100) if @progress

            return []
          end

          ret = analyzer.word_list.each_with_index.map { |word_2, i|
            @progress.call((i.to_f / total.to_f * 50.0).to_i + 50) if @progress
            next if word_2 == @word

            f_b = blocks.count { |b| b[word_2] }
            f_ab = blocks.count { |b| b[@word] && b[word_2] }

            # Somehow, it seems to be possible that f_b is zero. This
            # shouldn't happen, because it *should* be the case that
            # words that don't occur anywhere at all aren't included in the
            # parallel word list.
            next if f_b == 0

            l = (f_ab * n) / (f_a * f_b)
            l = Math.log(l) unless l.abs < 0.001

            [@word + ' ' + word_2, l]
          }.compact.sort { |a, b| b[1] <=> a[1] }.take(@num_pairs)

          @progress.call(100) if @progress

          ret
        end
      end
    end
  end
end
