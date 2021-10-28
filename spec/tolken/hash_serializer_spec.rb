# frozen_string_literal: true

require "tolken/hash_serializer"

RSpec.describe Tolken::HashSerializer do
  describe ".dump" do
    it "returns the hash given as is" do
      expect(described_class.dump(foo: "bar")).to eq(foo: "bar")
    end
  end

  describe ".load" do
    it "returns a hash if given a string" do
      expect(described_class.load({ foo: "bar" }.to_json)).to eq("foo" => "bar")
    end

    it "returns a hash if given a hash" do
      expect(described_class.load(foo: "bar")).to eq("foo" => "bar")
    end

    it "returned hash has indifferent access" do
      expect(described_class.load(foo: "bar")[:foo]).to eq("bar")
    end

    it "returns an empty hash if given nil" do
      expect(described_class.load(nil)).to eq({})
    end

    it "returns an empty hash if given false" do
      expect(described_class.load(false)).to eq({})
    end

    it "returns raises argument error if not given any argument" do
      expect { described_class.load }.to raise_error(ArgumentError)
    end
  end
end
