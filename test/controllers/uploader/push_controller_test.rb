require "test_helper"

module Uploader
  class PushControllerTest < ActionDispatch::IntegrationTest
    # include Engine.routes.url_helpers

    def setup
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

      @sign_up_datum_hash = {:form=>"yMGJyp", :form_name=>"东师 “前沿课堂”大家谈（2021春）全国初中数学教学在线观摩研讨会", :entry=>{:serial_number=>123, :total_price=>123, :preferential_price=>123, :trade_no=>"2013110473887777", :trade_status=>"TRADE_SUCCESS", :payment_method=>"alipay", :field_45=>"这是一行文字", :field_57=>"选项1", :field_70=>"选项1", :field_62=>"选项1", :field_58=>"这是一行文字", :field_71=>"这是一行文字", :field_68=>"选项1", :field_53=>{:province=>"陕西省", :city=>"西安市", :district=>"雁塔区", :street=>"高新路"}, :field_54=>"这是一行文字", :field_1=>"这是一行文字", :field_2=>"13812345678", :field_17=>"support@jinshuju.net", :field_69=>["https://example.jinshuju.net/en/key1?token=token&download"], :field_26=>"选项1", :field_56=>["https://example.jinshuju.net/en/key1?token=token&download", "https://example.jinshuju.net/en/key2?token=token&download"], :field_25=>[{:name=>"商品1", :number=>2}, {:name=>"商品2", :number=>10, :spec=>{:颜色=>"红"}}], :field_66=>[{:name=>"商品1", :number=>2}, {:name=>"商品2", :number=>10, :spec=>{:颜色=>"红"}}], :field_59=>"选项1", :field_63=>"选项1", :field_18=>"这是一行文字", :field_19=>"这是一行文字", :field_49=>{:province=>"陕西省", :city=>"西安市", :district=>"雁塔区", :street=>"高新路"}, :field_24=>"这是一行文字", :x_field_weixin_nickname=>"小王", :x_field_weixin_gender=>"男", :x_field_weixin_country=>"中国", :x_field_weixin_province_city=>{:province=>"陕西", :city=>"西安"}, :x_field_weixin_openid=>"adsfQWEasfxqw", :x_field_weixin_headimgurl=>"http://wx.qlogo.cn/mmopen/m8kRxejzzH0/0", :creator_name=>"小王", :created_at=>"2021-03-07T16:06:07.256Z", :updated_at=>"2021-03-07T16:06:07.256Z", :info_remote_ip=>"127.0.0.1"}}
    end

    teardown do
      # when controller is using cache it may be a good idea to reset it afterwards
      # Rails.cache.clear
    end

    test "right pass should create success" do
      # 'push/:form_identify/:pass_token'
      post "/push/yMGJyp/#{ENV.fetch("QIANYAN_PASS")}", params: @sign_up_datum_hash, as: :json
      assert_equal 1, SignUp::SignUpDatum.all.count
      assert_response :success
    end

    test "wrong pass shouldn't create sign up datum" do
      post "/push/yMGJyp/wrong_password", params: @sign_up_datum_hash, as: :json
      assert_equal 0, SignUp::SignUpDatum.all.count
      assert_response 203
    end

    test "same push datum, not create twice, updated_at not update" do
      post "/push/yMGJyp/#{ENV.fetch("QIANYAN_PASS")}", params: @sign_up_datum_hash, as: :json
      buf_updated_at = SignUp::SignUpDatum.first.updated_at

      post "/push/yMGJyp/#{ENV.fetch("QIANYAN_PASS")}", params: @sign_up_datum_hash, as: :json
      now_updated_at = SignUp::SignUpDatum.first.updated_at
      assert_equal 1, SignUp::SignUpDatum.all.count
      assert_equal buf_updated_at, now_updated_at
      assert_response :success
    end

    test "update push datum, db should be update, updated_at being update" do
      post "/push/yMGJyp/#{ENV.fetch("QIANYAN_PASS")}", params: @sign_up_datum_hash, as: :json
      buf_updated_at = SignUp::SignUpDatum.first.updated_at
      # change datum
      @sign_up_datum_hash[:entry][:creator_name] = "new_name"
      post "/push/yMGJyp/#{ENV.fetch("QIANYAN_PASS")}", params: @sign_up_datum_hash, as: :json

      assert_equal 1, SignUp::SignUpDatum.all.count
      datum = SignUp::SignUpDatum.first
      now_updated_at = datum.updated_at
      assert_equal "new_name", datum.entry["creator_name"]
      assert_not_equal buf_updated_at, now_updated_at
      assert_response :success
    end


  end
end
