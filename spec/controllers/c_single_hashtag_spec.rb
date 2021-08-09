require "./controllers/c_api_db_single_hashtag"

describe C_api_db_single_hashtag do
    before(:each) do
        @double = instance_double(C_api_db_single_hashtag)
    end
    it "should blank param username" do
        parameter = {"email"=>"reserved","bio"=>"reserved"}
        allow(@double).to receive(:cek_param_request).with(parameter).and_return({:hasil => true, :pesan => "Parameter username tidak ditemukan"})
        output = @double.cek_param_request(parameter)
        expect(@double).to have_received(:cek_param_request).with(parameter)
        expect(output).to eq({:hasil => true, :pesan => "Parameter username tidak ditemukan"})
        C_api_db_tambah_member.new.cek_param_request(parameter)
    end
end