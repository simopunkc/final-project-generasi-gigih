require "./controllers/c_api_db_search_hashtag"

describe C_api_db_search_hashtag do
    it "should render view search hashtag" do
        tag = M_raw_hashtag.new(4,'good')
        view = ERB.new(File.read("./views/v_api_db_search_hashtag.erb")).result(binding)
        output = C_api_db_search_hashtag.new.print_output(tag)
        expect(output).to eq(view)
    end
    before(:each) do
        @double = instance_double(C_api_db_search_hashtag)
    end
    it "should blank param nama hashtag" do
        parameter = {}
        allow(@double).to receive(:cek_param_request).with(parameter).and_return({:hasil => true, :pesan => "Nama hashtag tidak ditemukan"})
        output = @double.cek_param_request(parameter)
        expect(@double).to have_received(:cek_param_request).with(parameter)
        expect(output).to eq({:hasil => true, :pesan => "Nama hashtag tidak ditemukan"})
        C_api_db_search_hashtag.new.cek_param_request(parameter)
    end
    it "should blank value nama hashtag" do
        parameter = {:name=>""}
        allow(@double).to receive(:cek_valid).with(parameter[:name]).and_return({:hasil => true, :pesan => "Nama hashtag wajib diisi"})
        output = @double.cek_valid(parameter[:name])
        expect(@double).to have_received(:cek_valid).with(parameter[:name])
        expect(output).to eq({:hasil => true, :pesan => "Nama hashtag wajib diisi"})
        C_api_db_search_hashtag.new.cek_valid(parameter[:name])
    end
    it "should string value nama hashtag" do
        parameter = {:name=>"1"}
        allow(@double).to receive(:cek_valid).with(parameter[:name]).and_return({:hasil => true, :pesan => "Nama hashtag harus string"})
        output = @double.cek_valid(parameter[:name])
        expect(@double).to have_received(:cek_valid).with(parameter[:name])
        expect(output).to eq({:hasil => true, :pesan => "Nama hashtag harus string"})
        C_api_db_search_hashtag.new.cek_valid(parameter[:name])
    end
    it "should valid value param" do
        parameter = {:name=>"good"}
        allow(@double).to receive(:cek_valid).with(parameter[:name]).and_return({:hasil => false, :pesan => ""})
        output = @double.cek_valid(parameter[:name])
        expect(@double).to have_received(:cek_valid).with(parameter[:name])
        expect(output).to eq({:hasil => false, :pesan => ""})
        C_api_db_search_hashtag.new.cek_valid(parameter[:name])
    end
end