require "./controllers/c_api_db_single_post"

describe C_api_db_single_post do
    before(:each) do
        @double = instance_double(C_api_db_single_post)
    end
    it "should blank param id post" do
        parameter = {}
        allow(@double).to receive(:cek_param_request).with(parameter).and_return({:hasil => true, :pesan => "Param ID post tidak ditemukan"})
        output = @double.cek_param_request(parameter)
        expect(@double).to have_received(:cek_param_request).with(parameter)
        expect(output).to eq({:hasil => true, :pesan => "Param ID post tidak ditemukan"})
        C_api_db_single_post.new.cek_param_request(parameter)
    end
    it "should blank value id post" do
        post = M_raw_post.new('','',1,'lorem ipsum','')
        allow(@double).to receive(:cek_valid).with(post.id).and_return({:hasil => true, :pesan => "ID post wajib diisi"})
        output = @double.cek_valid(post.id)
        expect(@double).to have_received(:cek_valid).with(post.id)
        expect(output).to eq({:hasil => true, :pesan => "ID post wajib diisi"})
        C_api_db_single_post.new.cek_valid(post.id)
    end
    it "should integer value id post" do
        post = M_raw_post.new('a','a',1,'lorem ipsum','')
        allow(@double).to receive(:cek_valid).with(post.id).and_return({:hasil => true, :pesan => "ID post harus integer"})
        output = @double.cek_valid(post.id)
        expect(@double).to have_received(:cek_valid).with(post.id)
        expect(output).to eq({:hasil => true, :pesan => "ID post harus integer"})
        C_api_db_single_post.new.cek_valid(post.id)
    end
end