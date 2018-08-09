require "spec_helper"

RSpec.describe Tolken::Translates do
  with_model :Post do
    table { |t| t.jsonb(:title) }
    model do
      extend(Tolken)
      translates(:title)
    end
  end

  let(:post) { Post.create!(title: { en: "Hi", sv: "Hej" }) }

  describe "#translates" do
    describe "reader" do
      it "returns a hash of all available translations if given no translation key" do
        expect(post.title).to eq("en" => "Hi", "sv" => "Hej")
      end

      it "returns a the given translation if given a translation key" do
        expect(post.title(:en)).to eq("Hi")
        expect(post.title(:sv)).to eq("Hej")
      end

      it "returns nil if given registered locale key that has no translation" do
        expect(post.title(:de)).to eq(nil)
      end

      it "raises argument error if given non-registered locale key missing translation" do
        expect { post.title(:xy) }.to raise_error(ArgumentError, "Invalid locale xy")
      end
    end
    end
  end
end
