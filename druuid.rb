require 'securerandom'

# = Druuid
#
# Date-relative UUID generation.
module Druuid

  class << self

    # The offset from which Druuid UUIDs are generated (in seconds).
    attr_accessor :epoch
    # The bit of UUID
    attr_accessor :bit

    # Generates a time-sortable, 64-bit UUID.
    #
    # @example
    #   Druuid.gen
    #   # => 11142943683383068069
    # @param [Time] time of UUID
    # @param [Numeric] epoch offset
    # @param [Numeric] bit of UUID
    # @return [Bignum] UUID
    def gen time = Time.now, epoch = epoch, bit = 64
      ms = ((time.to_f - epoch.to_i) * 1e3).round
      rand = (SecureRandom.random_number * 1e16).round
      id = ms << (bit - 41)
      id | rand % (2 ** (bit - 41))
    end

    # Determines when a given UUID was generated.
    #
    # @param [Numeric] uuid
    # @param [Numeric] epoch offset
    # @param [Numeric] bit of UUID
    # @return [Time] when UUID was generated
    # @example
    #   Druuid.time 11142943683383068069
    #   # => 2012-02-04 00:00:00 -0800
    def time uuid, epoch = epoch, bit = 64
      ms = uuid >> (bit - 41)
      Time.at (ms / 1e3) + epoch.to_i
    end

  end

end
