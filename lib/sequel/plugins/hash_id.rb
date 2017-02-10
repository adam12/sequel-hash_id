require "forwardable"
require "hashids"

module Sequel::Plugins::HashId
  def self.apply(model, opts = {})
    model.instance_eval do
      @hash_id_state = {}
    end
  end

  def self.configure(model, opts = {})
    model.instance_eval do
      @hash_id_state[:salt] = opts[:salt] || raise(ArgumentError, "hash_id plugin missing salt option")
      @hash_id_state[:length] = opts[:length] || 0
    end
  end

  module ClassMethods
    Sequel::Plugins.def_dataset_methods(self, :with_hashid)

    def hasher
      Hashids.new(@hash_id_state[:salt], @hash_id_state[:length])
    end

    def with_hashid(hashid)
      id ,= hasher.decode(hashid)

      self[id] if id
    end
  end

  module InstanceMethods
    def hashid
      self.class.hasher.encode(id) if id
    end
  end

  module DatasetMethods
    extend Forwardable

    def_delegators :model, :with_hashid
  end
end
