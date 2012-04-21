# encoding: utf-8

module Veritas
  class Attribute

    # Represents a Numeric value in a relation tuple
    class Numeric < Object
      include Comparable,
              Aggregate::Sum::Methods

      DEFAULT_SIZE = (-::Float::INFINITY..::Float::INFINITY).freeze

      inheritable_alias(:range => :size)

      compare :name, :required?, :size

      # The Numeric range for a valid value
      #
      # @example
      #   numeric.size  # => 0..10
      #
      # @return [Range<::Numeric>]
      #
      # @api public
      attr_reader :size

      # The Numeric primitive
      #
      # @example
      #   Numeric.primitive  # => ::Numeric
      #
      # @return [Class<::Numeric>]
      #
      # @api public
      def self.primitive
        ::Numeric
      end

      # Initialize a Numeric Attribute
      #
      # @param [#to_sym] name
      #   the attribute name
      # @param [#to_hash] options
      #   the options for the attribute
      # @option options [Boolean] :required (true)
      #   if true, then the value cannot be nil
      # @option options [Range<::Numeric>] :size (0..2**31-1)
      #   The numeric range for a valid value
      #
      # @return [undefined]
      #
      # @api private
      def initialize(*)
        super
        @size = @options.fetch(:size, self.class::DEFAULT_SIZE).to_inclusive
      end

      # Test if the value matches the attribute constraints
      #
      # @example
      #   numeric.valid_value?(value)  # => true or false
      #
      # @param [Object] value
      #   the value to test
      #
      # @return [Boolean]
      #
      # @api public
      def valid_value?(value)
        valid_or_optional?(value) { super && size.cover?(value) }
      end

    end # class Numeric
  end # class Attribute
end # module Veritas
