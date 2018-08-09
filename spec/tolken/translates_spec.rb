require "spec_helper"

RSpec.describe Tolken::Translates do
  with_model :Post do
    table { |t| t.jsonb(:title) }
    model do
      extend(Tolken)
      translates(:title)
    end
  end

  describe "#translates" do
    describe "reader" do
      it "returns a hash of all available translations if given no translation key" do
        post = Post.create!(title: { en: "Hi", sv: "Hej" })
        expect(post.title).to eq("en" => "Hi", "sv" => "Hej")
      end

      it "returns a the given translation if given a translation key" do
        post = Post.create!(title: { en: "Hi", sv: "Hej" })

        expect(post.title(:en)).to eq("Hi")
        expect(post.title(:sv)).to eq("Hej")
      end
    end
  end
end
