require "./controllers/c_api_db_single_post"

describe C_api_db_single_post do
    it "should invalid id post" do
        allow(@double).to receive(:cek_valid).with(0).and_return({:hasil=>true, :pesan=>"ID post tidak ada di database"})
        output = @double.cek_valid(0)
        expect(@double).to have_received(:cek_valid).with(0)
        expect(output).to eq({:hasil=>true, :pesan=>"ID post tidak ada di database"})
        C_api_db_single_post.new.cek_valid(0)
    end
    it "should render view single post" do
        single_post = [[],[],[]]
        view = ERB.new(File.read("./views/v_api_db_single_post.erb")).result(binding)
        output = C_api_db_single_post.new.print_output(single_post)
        expect(output).to eq(view)
    end
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
        parameter = {:id=>""}
        allow(@double).to receive(:cek_valid).with(parameter[:id]).and_return({:hasil => true, :pesan => "ID post wajib diisi"})
        output = @double.cek_valid(parameter[:id])
        expect(@double).to have_received(:cek_valid).with(parameter[:id])
        expect(output).to eq({:hasil => true, :pesan => "ID post wajib diisi"})
        C_api_db_single_post.new.cek_valid(parameter[:id])
    end
    it "should integer value id post" do
        parameter = {:id=>"a"}
        allow(@double).to receive(:cek_valid).with(parameter[:id]).and_return({:hasil => true, :pesan => "ID post harus integer"})
        output = @double.cek_valid(parameter[:id])
        expect(@double).to have_received(:cek_valid).with(parameter[:id])
        expect(output).to eq({:hasil => true, :pesan => "ID post harus integer"})
        C_api_db_single_post.new.cek_valid(parameter[:id])
    end
    it "should valid value param" do
        parameter = {:id=>"1"}
        allow(@double).to receive(:cek_valid).with(parameter[:id]).and_return({:hasil => false, :pesan => ""})
        output = @double.cek_valid(parameter[:id])
        expect(@double).to have_received(:cek_valid).with(parameter[:id])
        expect(output).to eq({:hasil => false, :pesan => ""})
        C_api_db_single_post.new.cek_valid(parameter[:id])
    end
end