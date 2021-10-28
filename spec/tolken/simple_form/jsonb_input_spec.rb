# frozen_string_literal: true

require "spec_helper"
require "tolken/simple_form"

RSpec.describe Tolken::SimpleForm::JsonbInput do
  with_model :Post do
    table do |t|
      t.jsonb(:title)
    end

    model do
      extend(Tolken)
      translates(:title)
    end
  end

  let(:post) { Post.new(title: { en: "News", sv: "Nyheter" }) }
  let(:builder) { spy("builder", object: post) }
  let(:attribute_name) { "title" }
  let(:column) { "title" }
  let(:input_type) { spy("input_type") }
  let(:input_options) { {} }
  let(:input_builder) { described_class.new(builder, attribute_name, column, input_type, input_options) }

  describe "#input" do
    context "with no input options given" do
      it "calls the simple form builder once for each language" do
        input_builder.input

        expect(builder).to have_received(:input).with(
          :title_en,
          as: :string,
          input_html: { name: "post[title][en]", value: "News" }
        ).once

        expect(builder).to have_received(:input).with(
          :title_sv,
          as: :string,
          input_html: { name: "post[title][sv]", value: "Nyheter" }
        ).once
      end
    end

    context "with type set to :text" do
      let(:input_options) { { type: :text } }

      it "sets as to the input option type parameter" do
        input_builder.input

        expect(builder).to have_received(:input).with(
          :title_en,
          as: :text,
          input_html: { name: "post[title][en]", value: "News" }
        ).once

        expect(builder).to have_received(:input).with(
          :title_sv,
          as: :text,
          input_html: { name: "post[title][sv]", value: "Nyheter" }
        ).once
      end
    end
  end
end
