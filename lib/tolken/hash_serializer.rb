# frozen_string_literal: true

module Tolken
  class HashSerializer
    class << self
      def dump(hash)
        hash # ActiveRecord handles formatting this from a Ruby hash to psql jsonb
      end

      def load(hash)
        hash = JSON.parse(hash) if hash.is_a?(String)
        (hash || {}).with_indifferent_access
      end
    end
  end
end
