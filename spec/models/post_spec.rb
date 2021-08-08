require "./models/m_raw_post"
require "./models/m_api_db_tambah_post"

describe M_api_db_tambah_post do
    it "#insert_post" do
        member = M_raw_post.new('',1,0,'lorem ipsum')
        query = "INSERT INTO post (id_member,id_parent_post,text) values ('#{member.id_member}','#{member.id_parent_post}','#{member.text}')"
        mock = double
        allow(Mysql2::Client).to receive(:new).and_return(mock)
        expect(mock).to receive(:query).with(query)
        expect(mock).to receive(:last_id)
        M_api_db_tambah_post.new.insert_post(member.id_member,member.id_parent_post,member.text)
    end
    before(:each) do
        @double = instance_double(M_api_db_tambah_post)
    end
    it "should blank ID member" do
        member = M_raw_post.new('','','','lorem ipsum')
        allow(@double).to receive(:cek_valid).with(member.id_member,member.text).and_return({:hasil => true, :pesan => "ID member wajib diisi"})
        output = @double.cek_valid(member.id_member,member.text)
        expect(@double).to have_received(:cek_valid).with(member.id_member,member.text)
        expect(output).to eq({:hasil => true, :pesan => "ID member wajib diisi"})
        M_api_db_tambah_post.new.cek_valid(member.id_member,member.text)
    end
    it "should blank text" do
        member = M_raw_post.new('',1,'','')
        allow(@double).to receive(:cek_valid).with(member.id_member,member.text).and_return({:hasil => true, :pesan => "Text wajib diisi"})
        output = @double.cek_valid(member.id_member,member.text)
        expect(@double).to have_received(:cek_valid).with(member.id_member,member.text)
        expect(output).to eq({:hasil => true, :pesan => "Text wajib diisi"})
        M_api_db_tambah_post.new.cek_valid(member.id_member,member.text)
    end
    it "should limit 1000" do
        text = 'A'
        until text.length > 1000 do
            text += 'A'
        end
        member = M_raw_post.new('',1,'',text)
        allow(@double).to receive(:cek_valid).with(member.id_member,member.text).and_return({:hasil => true, :pesan => "Text maksimal 1000 karakter"})
        output = @double.cek_valid(member.id_member,member.text)
        expect(@double).to have_received(:cek_valid).with(member.id_member,member.text)
        expect(output).to eq({:hasil => true, :pesan => "Text maksimal 1000 karakter"})
        M_api_db_tambah_post.new.cek_valid(member.id_member,member.text)
    end
    it "should detect hashtag (alfabet,angka,underscore)" do
        member = M_raw_post.new('',1,'','#lorem haha #ipsum-5 jjk #generasigigih sir amet')
        output = M_api_db_tambah_post.new.get_hashtag(member.text)
        expect(output).to eq(['lorem','generasigigih'])
    end
end