module Uploader
  class FormStruct
    class Field
      attr_reader :field_identify, :label
      def initialize(field_hash)
        # field_hash already deep_symbolize_keys
        @field_identify = field_hash.keys.first
        value_hash = field_hash[field_id]

        @label = value_hash[:label]
      end


    end
  end
end
