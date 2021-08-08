require "./models/m_raw_post"
require "./models/m_raw_hashtag"
require "./models/m_api_db_tambah_post"

describe M_api_db_tambah_post do
    it "#insert_post" do
        post = M_raw_post.new('',1,0,'lorem ipsum','')
        query = "INSERT INTO tb_post (id_member,id_parent_post,text) values ('#{post.id_member}','#{post.id_parent_post}','#{post.text}')"
        mock = double
        allow(Mysql2::Client).to receive(:new).and_return(mock)
        expect(mock).to receive(:query).with(query)
        expect(mock).to receive(:last_id)
        M_api_db_tambah_post.new.insert_post(post.id_member,post.id_parent_post,post.text)
    end
    it "#insert_hashtag" do
        tag = M_raw_hashtag.new('','gigih')
        query = "INSERT INTO tb_hashtag (hashtag) values ('#{tag.hashtag}')"
        mock = double
        allow(Mysql2::Client).to receive(:new).and_return(mock)
        expect(mock).to receive(:query).with(query)
        expect(mock).to receive(:last_id)
        M_api_db_tambah_post.new.insert_hashtag(tag.hashtag)
    end
    it "#insert_hashtag_post" do
        tag = M_raw_hashtag.new(1,'gigih')
        post = M_raw_post.new(1,1,0,'lorem ipsum','')
        query = "INSERT INTO tb_hashtag_post (id_hashtag,id_post) values (#{tag.id},#{post.id})"
        mock = double
        allow(Mysql2::Client).to receive(:new).and_return(mock)
        expect(mock).to receive(:query).with(query)
        expect(mock).to receive(:last_id)
        M_api_db_tambah_post.new.insert_hashtag_post(tag.id,post.id)
    end
    it "#insert_post_comment" do
        post = M_raw_post.new('',1,1,'lorem ipsum','')
        query = "INSERT INTO tb_post (id_member,id_parent_post,text) values ('#{post.id_member}','#{post.id_parent_post}','#{post.text}')"
        mock = double
        allow(Mysql2::Client).to receive(:new).and_return(mock)
        expect(mock).to receive(:query).with(query)
        expect(mock).to receive(:last_id)
        M_api_db_tambah_post.new.insert_post(post.id_member,post.id_parent_post,post.text)
    end
    before(:each) do
        @double = instance_double(M_api_db_tambah_post)
    end
    it "should blank ID member" do
        post = M_raw_post.new('','','','lorem ipsum','')
        allow(@double).to receive(:cek_valid).with(post.id_member,post.text).and_return({:hasil => true, :pesan => "ID member wajib diisi"})
        output = @double.cek_valid(post.id_member,post.text)
        expect(@double).to have_received(:cek_valid).with(post.id_member,post.text)
        expect(output).to eq({:hasil => true, :pesan => "ID member wajib diisi"})
        M_api_db_tambah_post.new.cek_valid(post.id_member,post.text)
    end
    it "should blank text" do
        post = M_raw_post.new('',1,'','','')
        allow(@double).to receive(:cek_valid).with(post.id_member,post.text).and_return({:hasil => true, :pesan => "Text wajib diisi"})
        output = @double.cek_valid(post.id_member,post.text)
        expect(@double).to have_received(:cek_valid).with(post.id_member,post.text)
        expect(output).to eq({:hasil => true, :pesan => "Text wajib diisi"})
        M_api_db_tambah_post.new.cek_valid(post.id_member,post.text)
    end
    it "should limit 1000" do
        text = 'A'
        until text.length > 1000 do
            text += 'A'
        end
        post = M_raw_post.new('',1,'',text,'')
        allow(@double).to receive(:cek_valid).with(post.id_member,post.text).and_return({:hasil => true, :pesan => "Text maksimal 1000 karakter"})
        output = @double.cek_valid(post.id_member,post.text)
        expect(@double).to have_received(:cek_valid).with(post.id_member,post.text)
        expect(output).to eq({:hasil => true, :pesan => "Text maksimal 1000 karakter"})
        M_api_db_tambah_post.new.cek_valid(post.id_member,post.text)
    end
    it "should detect all hashtag (alfabet,angka,underscore)" do
        post = M_raw_post.new('',1,'','#lorem haha #ipsum-5 jjk #generasigigih sir','')
        output = M_api_db_tambah_post.new.get_hashtag(post.text)
        expect(output).to eq(['lorem','generasigigih'])
    end
    it "should detect id hashtag" do
        tag = M_raw_hashtag.new(1,'gigih')
        allow(@double).to receive(:get_id_hashtag).with(tag.hashtag).and_return(tag.id)
        output = @double.get_id_hashtag(tag.hashtag)
        expect(@double).to have_received(:get_id_hashtag).with(tag.hashtag)
        expect(output).to eq(tag.id)
        M_api_db_tambah_post.new.get_id_hashtag(tag.hashtag)
    end
    it "should duplicate hashtag on post" do
        tag = M_raw_hashtag.new(1,'gigih')
        post = M_raw_post.new(1,'','','','')
        allow(@double).to receive(:cek_duplikat_hashtag).with(tag.id,post.id).and_return(1)
        output = @double.cek_duplikat_hashtag(tag.id,post.id)
        expect(@double).to have_received(:cek_duplikat_hashtag).with(tag.id,post.id)
        expect(output).to eq(1)
        M_api_db_tambah_post.new.cek_duplikat_hashtag(tag.id,post.id)
    end
end