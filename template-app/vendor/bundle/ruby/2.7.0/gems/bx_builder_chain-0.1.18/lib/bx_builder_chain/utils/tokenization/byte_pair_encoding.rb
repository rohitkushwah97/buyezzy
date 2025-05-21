module BxBuilderChain
  module Utils
    module Tokenization
      class BytePairEncoding
        def initialize(pat_str:, mergeable_ranks:)
          @pat_str = pat_str
          @mergeable_ranks = mergeable_ranks
          @decoder = mergeable_ranks.invert
          @pat = Regexp.new(pat_str)
          @tokenized_string = []
        end

        def encode(text, visualise: nil)
          words = text.scan(@pat)
          words.flat_map { |word| bpe_encode(word.bytes, visualise: visualise) }
        end

        def visualise_tokenised_string
          visualise_tokens_coloured(@tokenized_string) unless @tokenized_string.empty?
        end

        private

        def bpe_encode(input, visualise: nil)
          parts = input.map(&:chr)
          visualiser = select_visualiser(visualise)

          until (min_pair = find_min_rank_pair(parts)).nil?
            visualiser.call(parts)
            idx = min_pair[:index]
            parts[idx, 2] = [parts[idx] + parts[idx + 1]]
          end

          @tokenized_string.concat(parts)
          puts '' unless visualise.nil?
          parts.map { |part| @mergeable_ranks[part] }
        end

        def find_min_rank_pair(parts)
            pairs = parts.each_cons(2).with_index.map do |pair, i|
              rank = @mergeable_ranks[pair.join]
              { pair: pair, rank: rank, index: i } if rank
            end.compact
            pairs.min_by { |entry| entry[:rank] }
        end

        def select_visualiser(mode)
          case mode
          when 'colour', 'color'
            method(:visualise_tokens_coloured)
          when 'simple'
            method(:visualise_tokens_simple)
          else
            ->(_tokens) {}
          end
        end

        def visualise_tokens_coloured(token_values)
          backgrounds = [167, 179, 185, 77, 80, 68, 134].cycle
          output = token_values.each_with_index.map do |value, index|
            "\e[48;5;#{backgrounds.next}m#{value}"
          end.join
          puts "#{output}\e[0m"
        end

        def visualise_tokens_simple(token_values)
          puts token_values
        end
      end
    end
  end
end