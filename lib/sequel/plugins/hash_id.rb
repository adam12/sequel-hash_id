# frozen-string-literal: true

require "hashids"

module Sequel::Plugins
  # This plugin allows you to easily obscure the primary key of your models with
  # an encoded hashid equivalent.
  #
  # A few convenience methods are provided which wrap around the +Hashids+ library.
  #
  # = Plugin Options
  #
  # :salt :: The salt used to hash/unhash the primary key values. Required.
  # :length :: By default, the length is variable. Setting an integer here forces
  #            all hashids to be a specific length.
  module HashId
    # @api private
    def self.apply(model, opts = {})
      model.instance_eval do
        @hash_id_state = {}
      end
    end

    # @api private
    def self.configure(model, opts = {})
      model.instance_eval do
        @hash_id_state[:salt] = opts[:salt] || raise(ArgumentError, "hash_id plugin missing salt option")
        @hash_id_state[:length] = opts[:length] || 0
      end
    end

    module ClassMethods
      Sequel::Plugins.def_dataset_methods(self, [:with_hashid, :with_hashid!])

      # The instance of +Hashids+ used to encode and decode values
      #
      # @return [Hashids]
      def hasher
        Hashids.new(@hash_id_state[:salt], @hash_id_state[:length])
      end
    end

    module InstanceMethods
      # The hashid of the model instance
      #
      # @return [String, nil]
      def hashid
        model.hasher.encode(id) if id
      end
    end

    module DatasetMethods
      # Lookup a record with a hashid, returning nil if none is found
      #
      # @param hashid [String]
      # @return [Object, nil]
      def with_hashid(hashid)
        id ,= model.hasher.decode(hashid)

        self[id] if id
      end

      # Lookup a record with a hashid, raising +Sequel::NoMatchingError+
      # if not found
      #
      # @param hashid [String]
      # @return [Object]
      # @raise [Sequel::NoMatchingError]
      def with_hashid!(hashid)
        id ,= model.hasher.decode(hashid)

        with_pk!(id)
      end
    end
  end
end
