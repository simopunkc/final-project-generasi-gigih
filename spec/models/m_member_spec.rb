require "./models/m_raw_member"
require "./models/m_api_db_tambah_member"

describe M_api_db_tambah_member do
    it "#insert_member" do
        member = M_raw_member.new('','programmer','admin@web.com','suka jalan-jalan')
        query = "INSERT INTO tb_member (username,email,bio) values ('#{member.username}','#{member.email}','#{member.bio}')"
        mock = double
        allow(Mysql2::Client).to receive(:new).and_return(mock)
        expect(mock).to receive(:query).with(query)
        expect(mock).to receive(:last_id)
        M_api_db_tambah_member.new.insert_member(member.username,member.email,member.bio)
    end
    before(:each) do
        @double = instance_double(M_api_db_tambah_member)
    end
    it "should duplicate username" do
        member = M_raw_member.new('','admin','programmer@web.com','')
        allow(@double).to receive(:cek_duplikat_username).with(member.username).and_return({:hasil => true, :pesan => "Username sudah digunakan"})
        output = @double.cek_duplikat_username(member.username)
        expect(@double).to have_received(:cek_duplikat_username).with(member.username)
        expect(output).to eq({:hasil => true, :pesan => "Username sudah digunakan"})
        M_api_db_tambah_member.new.cek_duplikat_username(member.username)
    end
    it "should duplicate email" do
        member = M_raw_member.new('','programmer','admin@web.com','')
        allow(@double).to receive(:cek_duplikat_email).with(member.username).and_return({:hasil => true, :pesan => "Email sudah digunakan"})
        output = @double.cek_duplikat_email(member.username)
        expect(@double).to have_received(:cek_duplikat_email).with(member.username)
        expect(output).to eq({:hasil => true, :pesan => "Email sudah digunakan"})
        M_api_db_tambah_member.new.cek_duplikat_email(member.username)
    end
end