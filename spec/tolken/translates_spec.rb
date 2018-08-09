require "spec_helper"

RSpec.describe Tolken::Translates do
  with_model :Post do
    table do |t|
      t.jsonb(:title)
    end

    model do
      extend(Tolken)
      translates(:title)
    end
  end

  with_model :Country do
    table do |t|
      t.jsonb(:name)
    end

    model do
      extend(Tolken)
      translates(:name, presence: true)
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

    describe "writer" do
      it "allows the translation hash to be set" do
        post.title = { en: "Bye", sv: "hej då", de: "Auf Wiedersehen" }
        expect(post.title).to eq("en" => "Bye", "sv" => "hej då", "de" => "Auf Wiedersehen")
      end

      it "persists hash with save!" do
        post.title = { en: "Bye", sv: "hej då", de: "Auf Wiedersehen" }
        post.save!

        expect(post.reload.title).to eq("en" => "Bye", "sv" => "hej då", "de" => "Auf Wiedersehen")
      end

      it "persists from constructor" do
        post = Post.new(title: { en: "Hi", sv: "Hej" })
        post.save!

        expect(post.reload.title).to eq("en" => "Hi", "sv" => "Hej")
      end

      it "persists modifled hash with save!" do
        post.title[:sv] = "hej då"
        post.save!

        expect(post.reload.title).to eq("en" => "Hi", "sv" => "hej då")
      end

      it "persists hash with update_attributes!" do
        post.update_attributes!(title: { en: "Bye", sv: "hej då", de: "Auf Wiedersehen" })
        expect(post.reload.title).to eq("en" => "Bye", "sv" => "hej då", "de" => "Auf Wiedersehen")
      end

      it "persists hash with update_attribute" do
        post.update_attribute(:title, { en: "Bye", sv: "hej då", de: "Auf Wiedersehen" })
        expect(post.reload.title).to eq("en" => "Bye", "sv" => "hej då", "de" => "Auf Wiedersehen")
      end

      it "adds validation error if presence option set to true when saving" do
        country = Country.new(name: { sv: "Sweden" })
        country.save

        expect(country.errors.messages).to eq(
          name: ["is invalid"], name_en: ["can't be blank"], name_de: ["can't be blank"]
        )
      end
    end
  end
end
