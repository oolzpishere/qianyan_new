module Uploader
  class FormStruct
    class Field
      attr_reader :field_identify, :label
      def initialize(field_hash)
        # field_hash is string keys for all
        @field_identify = field_hash.keys.first
        value_hash = field_hash[field_identify]

        @label = value_hash["label"]
      end


    end
  end
end
