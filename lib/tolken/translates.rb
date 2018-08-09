module Tolken
  module Translates
    def translates(*fields)
      fields.each do |field|
        define_getter(field)
        serialize(field, HashSerializer)
      end
    end

    private

    def define_getter(field)
      define_method(field) do |locale = nil|
        return self[field.to_sym] unless locale

        begin
          self[field.to_sym].fetch(locale.to_s)
        rescue IndexError
          raise ArgumentError, "Invalid locale #{locale}" unless I18n.available_locales.include?(locale.to_sym)
          nil
        end
      end
    end
  end
end
