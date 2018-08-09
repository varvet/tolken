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
        self[field.to_sym][locale.to_s]
      end
    end
  end
end
