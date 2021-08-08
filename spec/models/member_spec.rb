require "./models/m_raw_member"
require "./models/m_api_db_tambah_member"

describe M_api_db_tambah_member do
    it "#insert_member" do
        member = M_raw_member.new('','programmer','admin@web.com','suka jalan-jalan')
        query = "INSERT INTO member (username,email,bio) values ('#{member.username}','#{member.email}','#{member.bio}')"
        mock = double
        allow(Mysql2::Client).to receive(:new).and_return(mock)
        expect(mock).to receive(:query).with(query)
        expect(mock).to receive(:last_id)
        M_api_db_tambah_member.new.insert_member(member.username,member.email,member.bio)
    end
    before(:each) do
        @double = instance_double(M_api_db_tambah_member)
    end
    it "should blank username" do
        member = M_raw_member.new('','','admin@web.com','suka jalan-jalan')
        allow(@double).to receive(:cek_valid).with(member.username,member.email,member.bio).and_return({:hasil => true, :pesan => "Username wajib diisi"})
        output = @double.cek_valid(member.username,member.email,member.bio)
        expect(@double).to have_received(:cek_valid).with(member.username,member.email,member.bio)
        expect(output).to eq({:hasil => true, :pesan => "Username wajib diisi"})
        M_api_db_tambah_member.new.cek_valid(member.username,member.email,member.bio)
    end
    it "should blank email" do
        member = M_raw_member.new('','programmer','','suka jalan-jalan')
        allow(@double).to receive(:cek_valid).with(member.username,member.email,member.bio).and_return({:hasil => true, :pesan => "Email wajib diisi"})
        output = @double.cek_valid(member.username,member.email,member.bio)
        expect(@double).to have_received(:cek_valid).with(member.username,member.email,member.bio)
        expect(output).to eq({:hasil => true, :pesan => "Email wajib diisi"})
        M_api_db_tambah_member.new.cek_valid(member.username,member.email,member.bio)
    end
end