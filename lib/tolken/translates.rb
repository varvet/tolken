# frozen_string_literal: true

module Tolken
  module Translates
    def translates(field_name, options = {})
      define_getter(field_name)
      serialize(field_name, HashSerializer)

      return unless options[:presence]

      validation_names = I18n.available_locales.map { |locale| "#{field_name}_#{locale}" }
      readers = store_accessor(field_name, *validation_names)
      private(*(readers + readers.map { |name| "#{name}=" }))

      define_validator(field_name) if options[:presence]
    end

    private

    def define_getter(field_name)
      define_method(field_name) do |locale = nil|
        return self[field_name] unless locale

        begin
          self[field_name].fetch(locale.to_s)
        rescue IndexError
          raise ArgumentError, "Invalid locale #{locale}" unless I18n.available_locales.include?(locale.to_sym)

          nil
        end
      end
    end

    def define_validator(field)
      validate(
        proc do
          invalid = I18n.available_locales.map do |locale|
            errors.add(:"#{field}_#{locale}", :blank) if self[field][locale.to_s].blank?
          end

          errors.add(field) if invalid.compact.present?
        end
      )
    end
  end
end
