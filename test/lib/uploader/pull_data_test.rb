require "test_helper"

module Uploader
  class PullDataTest < ActionDispatch::IntegrationTest

    def setup
      @form_identify = "yMGJyp"
      @url = "https://jinshuju.net/api/v1/forms/" + @form_identify + "/entries"
      SignUp::Conference.create([
        { id: 1,
          name: "2021春全国初中数学",
          full_name: "东师 “前沿课堂”大家谈（2021春）全国初中数学教学在线观摩研讨会",
          eng_name: "twenty_one_junior_high_math",
          start_date: "2021/4/6",
          finish_date: "2021/4/7"}
      ])

      SignUp::SignUpForm.create([
        # jsj payment form 1
        { conference_id: 1,
          name: "（2021春）全国初中数学",
          form_identify: "yMGJyp",
          full_name: "东师 “前沿课堂”大家谈（2021春）全国初中数学教学在线观摩研讨会",
          form_type: "jsj_json",
          all_use_data_type: "jsj_json",
          form_struct: [{"field_45"=>{"label"=>"发票号", "type"=>"single_line_text", "notes"=>"", "private"=>true, "validation"=>{}}}, {"field_57"=>{"label"=>"银行转账确认", "type"=>"single_choice", "notes"=>"", "private"=>true, "validation"=>{}, "choices"=>[{"name"=>"已确认", "value"=>"wBkd", "hidden"=>false}, {"name"=>"未收到", "value"=>"7ZmF", "hidden"=>false}], "allow_other"=>false}}, {"field_70"=>{"label"=>"学生证确认", "type"=>"single_choice", "notes"=>"", "private"=>true, "validation"=>{}, "choices"=>[{"name"=>"已确认", "value"=>"ATYQ", "hidden"=>false}, {"name"=>"未确认", "value"=>"TQ7v", "hidden"=>false}], "allow_other"=>false}}, {"field_62"=>{"label"=>"直播密码发送状态", "type"=>"single_choice", "notes"=>"", "private"=>true, "validation"=>{}, "choices"=>[{"name"=>"已手动发送", "value"=>"wBkd", "hidden"=>false}, {"name"=>"未手动发送", "value"=>"7ZmF", "hidden"=>false}], "allow_other"=>false}}, {"field_58"=>{"label"=>"加发直播密码", "type"=>"single_line_text", "notes"=>"", "private"=>true, "validation"=>{}}}, {"field_71"=>{"label"=>"工作人员备注", "type"=>"single_line_text", "notes"=>"", "private"=>true, "validation"=>{}}}, {"field_68"=>{"label"=>"参会人身份", "type"=>"single_choice", "notes"=>"", "private"=>false, "validation"=>{"required"=>true}, "choices"=>[{"name"=>"中小学、培训学校教师", "value"=>"qetK", "hidden"=>false}, {"name"=>"教研员、辅导员、学校管理人员", "value"=>"JgZV", "hidden"=>false}, {"name"=>"高校教师、研究者", "value"=>"A63Z", "hidden"=>false}, {"name"=>"师范院校、普通院校在校学生", "value"=>"QVwv", "hidden"=>false}, {"name"=>"其他（三区三州、东师师生、东师教师教育创新实验区教师）", "value"=>"czIs", "hidden"=>false}], "allow_other"=>false}}, {"field_74"=>{"label"=>"“其他“参会代表报名说明", "type"=>"section_break", "notes"=>"<p>“三区三州、东师师生、东师教师教育创新实验区教师”点击报名页面链接，跳转至专用报名页面，并按要求提交审核材料：</p>\n\n<p><a href=\"https://www.wjx.cn/vm/rfhnWnw.aspx\" target=\"_blank\">https://www.wjx.cn/vm/rfhnWnw.aspx</a></p>\n\n<p>*点击该链接进行报名，无需填写下方信息</p>", "private"=>false, "validation"=>{}}}, {"field_53"=>{"label"=>"所在地", "type"=>"address", "notes"=>"", "private"=>false, "validation"=>{"required"=>true}}}, {"field_54"=>{"label"=>"学校/单位名称", "type"=>"single_line_text", "notes"=>"", "private"=>false, "validation"=>{"required"=>true}}}, {"field_1"=>{"label"=>"姓名", "type"=>"single_line_text", "notes"=>"", "private"=>false, "validation"=>{"required"=>true}}}, {"field_2"=>{"label"=>"手机", "type"=>"mobile", "notes"=>"", "private"=>false, "validation"=>{"required"=>true}}}, {"field_17"=>{"label"=>"邮箱", "type"=>"email", "notes"=>"<p>接收电子发票等</p>", "private"=>false, "validation"=>{"required"=>true}}}, {"field_69"=>{"label"=>"上传学生证照片", "type"=>"attachment", "notes"=>"<p>请上传本人学生证照片，含本人姓名、院校、专业、学制、入学时间、学校或院系章。工作人员审核通过后，直播验证码方可使用。</p>", "private"=>false, "validation"=>{}, "max_file_quantity"=>1, "media_type"=>{"type"=>"unlimited", "value"=>[]}}}, {"field_26"=>{"label"=>"缴费方式", "type"=>"single_choice", "notes"=>"", "private"=>false, "validation"=>{"required"=>true}, "choices"=>[{"name"=>"线上支付", "value"=>"kLNX", "hidden"=>false}, {"name"=>"银行汇款", "value"=>"sATL", "hidden"=>false}, {"name"=>"现场现金或刷卡交费", "value"=>"9OgL", "hidden"=>true}], "allow_other"=>false}}, {"field_56"=>{"label"=>"银行汇款凭证", "type"=>"attachment", "notes"=>"<p>请将银行汇款凭证照片（含网银付款凭证截图）上传，或发送到：，邮件名称同汇款附言内容一致</p>", "private"=>true, "validation"=>{}, "max_file_quantity"=>2, "media_type"=>{"type"=>"image", "value"=>["jpg", "jpeg", "png", "gif", "bmp", "psd", "tif"]}}}, {"field_25"=>{"label"=>"会务费", "type"=>"goods", "notes"=>"<p>每次提交只可报名1人。</p>", "private"=>false, "validation"=>{"required"=>true}, "goods_items"=>[{"name"=>"初中数学", "value"=>"qdVi", "description"=>nil, "inventory"=>nil, "hidden"=>false}, {"name"=>"2021测试", "value"=>"pp3R", "description"=>nil, "inventory"=>nil, "hidden"=>true}]}}, {"field_66"=>{"label"=>"会务费（在校学生）", "type"=>"goods", "notes"=>"<p>每次提交只可报名1人。</p>", "private"=>false, "validation"=>{}, "goods_items"=>[{"name"=>"初中数学", "value"=>"qdVi", "description"=>nil, "inventory"=>nil, "hidden"=>false}, {"name"=>"2020测试", "value"=>"pp3R", "description"=>nil, "inventory"=>nil, "hidden"=>true}]}}, {"field_59"=>{"label"=>"发票", "type"=>"single_choice", "notes"=>"", "private"=>false, "validation"=>{"required"=>true}, "choices"=>[{"name"=>"不开票", "value"=>"z9WH", "hidden"=>false}, {"name"=>"电子版（缴费后15天内推送到登记的电子邮箱）", "value"=>"tuUC", "hidden"=>false}, {"name"=>"纸质版（会议结束后40天内邮寄）", "value"=>"529o", "hidden"=>false}], "allow_other"=>false}}, {"field_63"=>{"label"=>"发票费用类型", "type"=>"single_choice", "notes"=>"", "private"=>false, "validation"=>{"required"=>true}, "choices"=>[{"name"=>"培训费", "value"=>"z4bN", "hidden"=>false}, {"name"=>"会务费", "value"=>"Ou4s", "hidden"=>false}], "allow_other"=>false}}, {"field_18"=>{"label"=>"发票单位全称（开发票抬头）", "type"=>"single_line_text", "notes"=>"<p>请务必问清楚财务单位报销抬头，无需开具发票的请填“无”</p>", "private"=>false, "validation"=>{"required"=>true}}}, {"field_19"=>{"label"=>"纳税人识别号（统一社会信用代码）", "type"=>"single_line_text", "notes"=>"<p>请务必问清楚财务单位的纳税人识别号（统一社会信用代码），若确认不需要就填“无”。如因发票信息提供错误，请恕无法重开。</p>", "private"=>false, "validation"=>{"required"=>true, "maximum_length"=>18}}}, {"field_49"=>{"label"=>"详细邮寄地址", "type"=>"address", "notes"=>"<p>如需纸质发票请填写。无需纸质发票可不填。</p>", "private"=>false, "validation"=>{"required"=>true}}}, {"field_24"=>{"label"=>"备注", "type"=>"single_line_text", "notes"=>"", "private"=>false, "validation"=>{}}}].to_json
        }
      ])

      @json_datum3 = "{\"serial_number\":3,\"total_price\":0.01,\"preferential_price\":0,\"trade_no\":\"4200000892202102268087060653\",\"trade_status\":\"SUCCESS\",\"payment_method\":\"微信支付\",\"field_45\":\"\",\"field_57\":\"\",\"field_70\":\"\",\"field_62\":\"\",\"field_58\":\"\",\"field_71\":\"\",\"field_68\":\"教研员、辅导员、学校管理人员\",\"field_53\":{\"province\":\"山西省\",\"city\":\"太原市\",\"district\":\"晋源区\"},\"field_54\":\"测试学校\",\"field_1\":\"测试112\",\"field_2\":\"15977793123\",\"field_17\":\"page_lee@qq.com\",\"field_69\":[],\"field_26\":\"线上支付\",\"field_56\":[],\"field_25\":[{\"name\":\"2021测试\",\"number\":1}],\"field_66\":[],\"field_59\":\"纸质版（会议结束后40天内邮寄）\",\"field_63\":\"培训费\",\"field_18\":\"测试\",\"field_19\":\"518464996464\",\"field_49\":{\"province\":\"河北省\",\"city\":\"沧州市\",\"district\":\"河间市\",\"street\":\"测试\"},\"field_24\":\"\",\"x_field_weixin_nickname\":\"\",\"x_field_weixin_gender\":\"\",\"x_field_weixin_country\":\"\",\"x_field_weixin_province_city\":{},\"x_field_weixin_openid\":\"o5m8i049i6bQTKEiXYJEZAIwUTjU\",\"x_field_weixin_headimgurl\":\"\",\"info_filling_duration\":44.0,\"creator_name\":\"\",\"created_at\":\"2021-02-26T03:35:50.875Z\",\"updated_at\":\"2021-02-26T03:35:50.875Z\"}"
      @json_datum5 = "{\"serial_number\":5,\"total_price\":100,\"preferential_price\":0,\"trade_no\":\"\",\"trade_status\":\"\",\"payment_method\":\"\",\"field_45\":\"\",\"field_57\":\"\",\"field_70\":\"\",\"field_62\":\"\",\"field_58\":\"\",\"field_71\":\"\",\"field_68\":\"师范院校、普通院校在校学生\",\"field_53\":{\"province\":\"山西省\",\"city\":\"太原市\",\"district\":\"晋源区\"},\"field_54\":\"测试学校\",\"field_1\":\"测试13\",\"field_2\":\"15977793123\",\"field_17\":\"page_lee@qq.com\",\"field_69\":[\"https://gd-pri.jinshujufiles.com/en/yMGJyp/Fr024Qr0cQTK9xlOIpvs4v51mH-K_field_69_1614310800.png?token=7NK_Z1IEoKaIY6I9RXzO4b9uQPwuwdvnlGbzHZmF:T8-EIBW5bOG-IHlL6x13DC5J7wk=:eyJTIjoiZ2QtcHJpLmppbnNodWp1ZmlsZXMuY29tL2VuL3lNR0p5cC9GcjAyNFFyMGNRVEs5eGxPSXB2czR2NTFtSC1LX2ZpZWxkXzY5XzE2MTQzMTA4MDAucG5nKiIsIkUiOjE5MzA3OTQwMTN9\\u0026download\\u0026attname=序号5_69_1_S10217-17131683.png\"],\"field_26\":\"银行汇款\",\"field_56\":[],\"field_25\":[],\"field_66\":[{\"name\":\"初中数学\",\"number\":1}],\"field_59\":\"\",\"field_63\":\"\",\"field_18\":\"\",\"field_19\":\"\",\"field_49\":{},\"field_24\":\"\",\"x_field_weixin_nickname\":\"\",\"x_field_weixin_gender\":\"\",\"x_field_weixin_country\":\"\",\"x_field_weixin_province_city\":{},\"x_field_weixin_openid\":\"o5m8i049i6bQTKEiXYJEZAIwUTjU\",\"x_field_weixin_headimgurl\":\"\",\"info_filling_duration\":82.0,\"creator_name\":\"\",\"created_at\":\"2021-02-26T03:40:16.146Z\",\"updated_at\":\"2021-02-26T03:40:16.146Z\"}"
      @json_datum6 = "{\"serial_number\":6,\"total_price\":0,\"preferential_price\":0,\"trade_no\":\"\",\"trade_status\":\"\",\"payment_method\":\"\",\"field_45\":\"\",\"field_57\":\"\",\"field_70\":\"\",\"field_62\":\"\",\"field_58\":\"\",\"field_71\":\"\",\"field_68\":\"其他（三区三州、东师师生、东师教师教育创新实验区教师）\",\"field_53\":{\"province\":\"吉林省\",\"city\":\"长春市\",\"district\":\"南关区\"},\"field_54\":\"东北师范大学\",\"field_1\":\"周絮\",\"field_2\":\"18226899813\",\"field_17\":\"ordinary-678@qq.com\",\"field_69\":[],\"field_26\":\"\",\"field_56\":[],\"field_25\":[],\"field_66\":[],\"field_59\":\"\",\"field_63\":\"\",\"field_18\":\"\",\"field_19\":\"\",\"field_49\":{},\"field_24\":\"\",\"x_field_weixin_nickname\":\"\",\"x_field_weixin_gender\":\"\",\"x_field_weixin_country\":\"\",\"x_field_weixin_province_city\":{},\"x_field_weixin_openid\":\"o5m8i03IFupR5AYSDGLr_k-b2wuY\",\"x_field_weixin_headimgurl\":\"\",\"info_filling_duration\":53.0,\"creator_name\":\"\",\"created_at\":\"2021-03-05T01:53:36.561Z\",\"updated_at\":\"2021-03-05T01:53:36.561Z\"}"
      @json_datum7 = "{\"serial_number\":7,\"total_price\":380,\"preferential_price\":0,\"trade_no\":\"4200000889202103086464966722\",\"trade_status\":\"SUCCESS\",\"payment_method\":\"微信支付\",\"field_45\":\"\",\"field_57\":\"\",\"field_70\":\"\",\"field_62\":\"\",\"field_58\":\"\",\"field_71\":\"\",\"field_68\":\"高校教师、研究者\",\"field_53\":{\"province\":\"浙江省\",\"city\":\"宁波市\",\"district\":\"江北区\"},\"field_54\":\"宁波大学\",\"field_1\":\"林玉慈\",\"field_2\":\"13957890924\",\"field_17\":\"orange1236@126.com\",\"field_69\":[],\"field_26\":\"线上支付\",\"field_56\":[],\"field_25\":[{\"name\":\"初中数学\",\"number\":1}],\"field_66\":[],\"field_59\":\"纸质版（会议结束后40天内邮寄）\",\"field_63\":\"会务费\",\"field_18\":\"宁波大学\",\"field_19\":\"123300004195291066\",\"field_49\":{\"province\":\"浙江省\",\"city\":\"宁波市\",\"district\":\"江北区\",\"street\":\"宁波市江北区风华路818号宁波大学\"},\"field_24\":\"名称：宁波大学 纳税人识别号：123300004195291066 开户银行账号：工行宁波江北支行3901130009000002464 地址电话：宁波市江北区风华路818号，87609020\",\"x_field_weixin_nickname\":\"\",\"x_field_weixin_gender\":\"\",\"x_field_weixin_country\":\"\",\"x_field_weixin_province_city\":{},\"x_field_weixin_openid\":\"o5m8i0x8g6ZD1s1sAR_JyqKVMh_s\",\"x_field_weixin_headimgurl\":\"\",\"info_filling_duration\":318.0,\"creator_name\":\"\",\"created_at\":\"2021-03-08T08:24:20.795Z\",\"updated_at\":\"2021-03-08T08:24:20.795Z\"}"
      json_array = [@json_datum3, @json_datum5]
      # all: 3,5,6,7; default: 3,7
      @json = set_json(json_array)
    end

    def set_json(json_array)
      num = json_array.count
      "{\"total\":#{num},\"count\":#{num},\"data\":[#{ json_array.join(',') }],\"next\":null}"
    end

    test "pull data and create sign_up_datum success" do
      stub_request(:any, @url).
        to_return body: @json,
        status: 200, headers: {content_type: 'application/json'}

      Uploader::PullData.pull_form(@form_identify)
      assert_equal 2, SignUp::SignUpDatum.count
    end

    test "add 1 sign_up_datum success" do
      json_array = [@json_datum3, @json_datum5, @json_datum7]
      stub_request(:any, @url).
        to_return body: set_json(json_array),
        status: 200, headers: {content_type: 'application/json'}

      Uploader::PullData.pull_form(@form_identify)
      assert_equal 3, SignUp::SignUpDatum.count
    end

    test "update json_datum3, json_datum5 not update" do
      stub_request(:any, @url).
        to_return body: @json,
        status: 200, headers: {content_type: 'application/json'}
      Uploader::PullData.pull_form(@form_identify)
      old_enroll_datum = Uploader::EnrollDatum.new(SignUp::SignUpDatum.first.entry, @form_identify)
      old_total_price = old_enroll_datum.entry[:total_price]
      old_first_updated_at = SignUp::SignUpDatum.first.updated_at
      old_last_updated_at = SignUp::SignUpDatum.last.updated_at

      json_datum3 = JSON.parse(@json_datum3).deep_symbolize_keys
      json_datum3[:total_price] = 666
      @json_datum3 = json_datum3.to_json
      json_array = [@json_datum3, @json_datum5]

      stub_request(:any, @url).
        to_return body: set_json(json_array),
        status: 200, headers: {content_type: 'application/json'}

      Uploader::PullData.pull_form(@form_identify)
      enroll_datum = Uploader::EnrollDatum.new(SignUp::SignUpDatum.first.entry, @form_identify)
      assert_equal 0.01, old_total_price
      assert_equal 666, enroll_datum.entry[:total_price]
      assert_not_equal old_first_updated_at, SignUp::SignUpDatum.first.updated_at
      assert_equal old_last_updated_at, SignUp::SignUpDatum.last.updated_at
    end

    test "update test, same json_datum3 not update" do
      stub_request(:any, @url).
        to_return body: @json,
        status: 200, headers: {content_type: 'application/json'}

      Uploader::PullData.pull_form(@form_identify)
      old_datum_updated_at = SignUp::SignUpDatum.first.updated_at

      Uploader::PullData.pull_form(@form_identify)
      assert_equal old_datum_updated_at, SignUp::SignUpDatum.first.updated_at
    end

    test "delete test, pull 3,5,7, then pull 3,7, should delete 5 " do
      # pull 3,5,7
      json_array = [@json_datum3, @json_datum5, @json_datum7]
      stub_request(:any, @url).
        to_return body: set_json(json_array),
        status: 200, headers: {content_type: 'application/json'}

      Uploader::PullData.pull_form(@form_identify)
      assert_equal [3,5,7], SignUp::SignUpDatum.all.map {|d| d.jsj_id}

      # pull 3,7
      json_array = [@json_datum3, @json_datum7]
      stub_request(:any, @url).
        to_return body: set_json(json_array),
        status: 200, headers: {content_type: 'application/json'}
      Uploader::PullData.pull_form(@form_identify)
      assert_equal [3,7], SignUp::SignUpDatum.all.map {|d| d.jsj_id}
    end

    test "delete test, pull 3,5,7, then pull 5, should delete nothing " do
      # pull 3,5,7
      json_array = [@json_datum3, @json_datum5, @json_datum7]
      stub_request(:any, @url).
        to_return body: set_json(json_array),
        status: 200, headers: {content_type: 'application/json'}

      Uploader::PullData.pull_form(@form_identify)
      assert_equal [3,5,7], SignUp::SignUpDatum.all.map {|d| d.jsj_id}

      # pull 5
      json_array = [@json_datum5]
      stub_request(:any, @url).
        to_return body: set_json(json_array),
        status: 200, headers: {content_type: 'application/json'}
      Uploader::PullData.pull_form(@form_identify)
      assert_equal [3,5,7], SignUp::SignUpDatum.all.map {|d| d.jsj_id}
    end

    test "delete test, pull 3,5,7, then pull 3,6,7, should delete 5 and add 6 " do
      # pull 3,5,7
      json_array = [@json_datum3, @json_datum5, @json_datum7]
      stub_request(:any, @url).
        to_return body: set_json(json_array),
        status: 200, headers: {content_type: 'application/json'}

      Uploader::PullData.pull_form(@form_identify)
      assert_equal [3,5,7], SignUp::SignUpDatum.all.map {|d| d.jsj_id}

      # pull 3,6,7
      json_array = [@json_datum3, @json_datum6, @json_datum7]
      stub_request(:any, @url).
        to_return body: set_json(json_array),
        status: 200, headers: {content_type: 'application/json'}
      Uploader::PullData.pull_form(@form_identify)
      assert_equal [3,7,6], SignUp::SignUpDatum.all.map {|d| d.jsj_id}
    end

  end
end
