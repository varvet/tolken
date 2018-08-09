# frozen_string_literal: true

require "rails"
require "simple_form"
require_relative "../tolken"

module Tolken
  module SimpleForm
    class JsonbInput < ::SimpleForm::Inputs::StringInput
      include ActionView::Helpers::OutputSafetyHelper

      def input(_wrapper_options = {})
        safe_join(
          I18n.available_locales.map do |locale|
            options = {
              input_html: {
                name: "#{object.class.to_s.downcase}[#{attribute_name}][#{locale}]",
                value: object.public_send(attribute_name)[locale]
              },
              as: input_options[:type].presence || :string
            }

            @builder.input(:"#{attribute_name}_#{locale}", options)
          end
        )
      end

      def label(_wrapper_options = {})
        # label is rendered per translatable field
      end
    end
  end
end

JsonbInput = Tolken::SimpleForm::JsonbInput
