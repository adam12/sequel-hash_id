require "forwardable"
require "hashids"

module Sequel::Plugins # :nodoc:
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
  def self.apply(model, opts = {}) # :nodoc:
    model.instance_eval do
      @hash_id_state = {}
    end
  end

  def self.configure(model, opts = {}) # :nodoc:
    model.instance_eval do
      @hash_id_state[:salt] = opts[:salt] || raise(ArgumentError, "hash_id plugin missing salt option")
      @hash_id_state[:length] = opts[:length] || 0
    end
  end

  module ClassMethods
    Sequel::Plugins.def_dataset_methods(self, [:with_hashid, :with_hashid!])

    # The instance of +Hashids+ used to encode and decode values
    def hasher
      Hashids.new(@hash_id_state[:salt], @hash_id_state[:length])
    end
  end

  module InstanceMethods
    # The hashid of the model instance
    def hashid
      model.hasher.encode(id) if id
    end
  end

  module DatasetMethods
    # extend Forwardable

    # def_delegators :model, :with_hashid, :with_hashid!

    # Lookup a record with a hashid, returning nil if none is found
    def with_hashid(hashid)
      id ,= model.hasher.decode(hashid)

      self[id] if id
    end

    # Lookup a record with a hashid, raising +Sequel::NoMatchingError+
    # if not found
    def with_hashid!(hashid)
      id ,= model.hasher.decode(hashid)

      with_pk!(id)
    end
  end
end
end
