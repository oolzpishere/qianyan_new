module Uploader
  module PullData
    class HandleResults
      attr_reader :results, :form_identify, :sign_up_form, :source_enroll_data, :db_enroll_data, :delete_db_jsj_ids, :create_source_jsj_ids, :update_source_jsj_ids

      def initialize( form_identify, results )
        # results: {:total=>7, :count=>7, :data=>[{:serial_number=>1...}..], :next=>nil}
        # data: sign up datum array
        # next: when not next, it will be nil.
        @form_identify = form_identify
        @sign_up_form = find_form
        @results = results
      end

      def invoke
        # data: [{:serial_number=>1, ...}...]
        data = results[:data]
        @source_enroll_data = data.map {|d| Uploader::EnrollDatum.new(d, form_identify)}

        start_id = source_enroll_data.first.jsj_id
        end_id = source_enroll_data.last.jsj_id
        # get_jsj_range_array in db
        db_array = get_jsj_range_array_in_db(sign_up_form.id, start_id, end_id)
        @db_enroll_data ||= []
        @db_enroll_data = db_array.map {|d| Uploader::EnrollDatum.new(d.entry, form_identify)}

        # compare source_array with db array, and generate create, delete, update ids
        compare_source_with_db

        # create_source_jsj_ids
        _create_source_enroll_data = create_source_enroll_data(create_source_jsj_ids)
        _create_source_enroll_data_params_array = _create_source_enroll_data.map {|d| d.to_params}
        SignUp::SignUpDatum.create( _create_source_enroll_data_params_array )
        # delete_db_jsj_ids
        _delete_db_ids_array = delete_db_ids_array(db_array, delete_db_jsj_ids)
        SignUp::SignUpDatum.delete(_delete_db_ids_array)
        # update diff: update_source_jsj_ids
        _update_db_array = select_db_array(db_array, update_source_jsj_ids)
        _update_db_array.each do |d|
          d.update( find_source_datum(d.jsj_id).to_params )
        end
      end

      private

      def find_form
        SignUp::SignUpForm.find_by(form_identify: form_identify)
      end

      def get_jsj_range_array_in_db(sign_up_form_id, start_id, end_id)
        SignUp::SignUpDatum.where( sign_up_form_id: sign_up_form_id ).and( SignUp::SignUpDatum.where( jsj_id: (start_id..end_id).to_a ) )
      end

      def compare_source_with_db
        source_id_array = source_enroll_data.map {|item| item.jsj_id}
        db_id_array = (db_enroll_data ? (db_enroll_data.map {|item| item.jsj_id}) : [])
        intersection_id_array = source_id_array & db_id_array
        # select extra in source, and create those
        @create_source_jsj_ids ||= []
        @create_source_jsj_ids = source_id_array - intersection_id_array
        # select extra in db, and delete those
        @delete_db_jsj_ids ||= []
        @delete_db_jsj_ids = db_id_array - intersection_id_array
        compare_intersection(intersection_id_array)
      end

      def compare_intersection(intersection_id_array)
        # select source_intersection_data
        source_intersection_data = source_enroll_data.select {
          |d| intersection_id_array.include?( d.jsj_id ) }
        # compare each entry of datum, return diff array.
        compare_source_intersection_data(source_intersection_data)
      end

      def compare_source_intersection_data(source_intersection_data)
        @update_source_jsj_ids = []
        source_intersection_data.each do |source_datum|
          jsj_id = source_datum.jsj_id
          if (source_datum.entry != find_db_datum(jsj_id).entry)
            update_source_jsj_ids << jsj_id
          end
        end
        update_source_jsj_ids
      end

      def find_db_datum(jsj_id)
        db_enroll_data.find { |d| d.jsj_id == jsj_id }
      end

      def find_source_datum(jsj_id)
        source_enroll_data.find { |d| d.jsj_id == jsj_id }
      end

      def create_source_enroll_data(create_source_jsj_ids)
        source_enroll_data.select {|d| create_source_jsj_ids.include?(d.jsj_id)}
      end

      def delete_db_ids_array(db_array, delete_db_jsj_ids)
        array = select_db_array(db_array, delete_db_jsj_ids)
        array.map { |d| d.id }
      end

      def select_db_array(db_array, ids)
        db_array.select { |d| ids.include?(d.jsj_id) }
      end

    end
  end
end
