require "./controllers/c_api_db_tambah_member"
require "./models/m_api_db_tambah_member"

describe C_api_db_tambah_member do
    before(:each) do
        @double = instance_double(C_api_db_tambah_member)
    end
    it "should blank param username" do
        parameter = {"email"=>"reserved","bio"=>"reserved"}
        allow(@double).to receive(:cek_param_request).with(parameter).and_return({:hasil => true, :pesan => "Parameter username tidak ditemukan"})
        output = @double.cek_param_request(parameter)
        expect(@double).to have_received(:cek_param_request).with(parameter)
        expect(output).to eq({:hasil => true, :pesan => "Parameter username tidak ditemukan"})
        C_api_db_tambah_member.new.cek_param_request(parameter)
    end
    it "should blank param email" do
        parameter = {"username"=>"reserved","bio"=>"reserved"}
        allow(@double).to receive(:cek_param_request).with(parameter).and_return({:hasil => true, :pesan => "Parameter email tidak ditemukan"})
        output = @double.cek_param_request(parameter)
        expect(@double).to have_received(:cek_param_request).with(parameter)
        expect(output).to eq({:hasil => true, :pesan => "Parameter email tidak ditemukan"})
        C_api_db_tambah_member.new.cek_param_request(parameter)
    end
    it "should blank param bio" do
        parameter = {"username"=>"reserved","email"=>"reserved"}
        allow(@double).to receive(:cek_param_request).with(parameter).and_return({:hasil => true, :pesan => "Parameter bio tidak ditemukan"})
        output = @double.cek_param_request(parameter)
        expect(@double).to have_received(:cek_param_request).with(parameter)
        expect(output).to eq({:hasil => true, :pesan => "Parameter bio tidak ditemukan"})
        C_api_db_tambah_member.new.cek_param_request(parameter)
    end
    it "should complete param json" do
        parameter = {"username"=>"reserved","email"=>"reserved","bio"=>"reserved"}
        allow(@double).to receive(:cek_param_request).with(parameter).and_return({:hasil => false, :pesan => ""})
        output = @double.cek_param_request(parameter)
        expect(@double).to have_received(:cek_param_request).with(parameter)
        expect(output).to eq({:hasil => false, :pesan => ""})
        C_api_db_tambah_member.new.cek_param_request(parameter)
    end
    it "should blank username" do
        member = M_raw_member.new('','','programmer@web.com','')
        allow(@double).to receive(:cek_valid).with(member.username,member.email,member.bio).and_return({:hasil => true, :pesan => "Username wajib diisi"})
        output = @double.cek_valid(member.username,member.email,member.bio)
        expect(@double).to have_received(:cek_valid).with(member.username,member.email,member.bio)
        expect(output).to eq({:hasil => true, :pesan => "Username wajib diisi"})
        C_api_db_tambah_member.new.cek_valid(member.username,member.email,member.bio)
    end
    it "should blank email" do
        member = M_raw_member.new('','programmer','','')
        allow(@double).to receive(:cek_valid).with(member.username,member.email,member.bio).and_return({:hasil => true, :pesan => "Email wajib diisi"})
        output = @double.cek_valid(member.username,member.email,member.bio)
        expect(@double).to have_received(:cek_valid).with(member.username,member.email,member.bio)
        expect(output).to eq({:hasil => true, :pesan => "Email wajib diisi"})
        C_api_db_tambah_member.new.cek_valid(member.username,member.email,member.bio)
    end
    it "should duplicate username" do
        member = M_raw_member.new('','admin','programmer@web.com','')
        allow(@double).to receive(:cek_valid).with(member.username,member.email,member.bio).and_return({:hasil => true, :pesan => "Username sudah digunakan"})
        output = @double.cek_valid(member.username,member.email,member.bio)
        expect(@double).to have_received(:cek_valid).with(member.username,member.email,member.bio)
        expect(output).to eq({:hasil => true, :pesan => "Username sudah digunakan"})
        C_api_db_tambah_member.new.cek_valid(member.username,member.email,member.bio)
    end
    it "should duplicate email" do
        member = M_raw_member.new('','programmer','admin@web.com','')
        allow(@double).to receive(:cek_valid).with(member.username,member.email,member.bio).and_return({:hasil => true, :pesan => "Email sudah digunakan"})
        output = @double.cek_valid(member.username,member.email,member.bio)
        expect(@double).to have_received(:cek_valid).with(member.username,member.email,member.bio)
        expect(output).to eq({:hasil => true, :pesan => "Email sudah digunakan"})
        C_api_db_tambah_member.new.cek_valid(member.username,member.email,member.bio)
    end
end