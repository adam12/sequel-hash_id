require "minitest/autorun"
require "sequel"

class TestSequelHashId < Minitest::Test
  def setup
    @db = Sequel.mock(fetch: { id: 1 })
    @model = Class.new(Sequel::Model(@db[:test]))
  end

  def test_salt_required
    assert_raises ArgumentError do
      @model.plugin :hash_id
    end
  end

  def test_custom_length
    @model.plugin :hash_id, salt: "the-salt", length: 10

    instance = @model.new
    def instance.id
      15
    end

    assert_equal 10, instance.hashid.length
  end

  def test_with_hashid
    @model.plugin :hash_id, salt: "the-salt"
    instance = @model.create

    assert_equal instance, @model.with_hashid(instance.hashid)
  end

  def test_invalid_hashid
    @model.plugin :hash_id, salt: "the-salt"

    assert_nil @model.with_hashid("invalid")
  end

  def test_dataset_method
    @model.plugin :hash_id, salt: "the-salt"
    hashid = @model.hasher.encode(1)

    refute_nil @model.dataset.with_hashid(hashid)
  end
end
