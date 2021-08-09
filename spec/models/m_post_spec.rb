require "./models/m_raw_post"
require "./models/m_raw_hashtag"
require "./models/m_raw_media"
require "./models/m_raw_member"
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
    it "#insert_media" do
        media = M_raw_media.new('','upload/file.jpg','.jpg')
        query = "INSERT INTO tb_media (lokasi,ext) values ('#{media.lokasi}','#{media.ext}')"
        mock = double
        allow(Mysql2::Client).to receive(:new).and_return(mock)
        expect(mock).to receive(:query).with(query)
        expect(mock).to receive(:last_id)
        M_api_db_tambah_post.new.insert_media(media.lokasi,media.ext)
    end
    it "#insert_post_media" do
        post = M_raw_post.new(1,1,0,'lorem ipsum','')
        media = M_raw_media.new(1,'upload/file.jpg','.jpg')
        query = "INSERT INTO tb_post_media (id_post,id_media) values (#{post.id},#{media.id})"
        mock = double
        allow(Mysql2::Client).to receive(:new).and_return(mock)
        expect(mock).to receive(:query).with(query)
        expect(mock).to receive(:last_id)
        M_api_db_tambah_post.new.insert_post_media(post.id,media.id)
    end
    before(:each) do
        @double = instance_double(M_api_db_tambah_post)
    end
    it "should valid id_member" do
        member = M_raw_member.new(1,'','','')
        allow(@double).to receive(:cek_id_member).with(member.id).and_return(1)
        output = @double.cek_id_member(member.id)
        expect(@double).to have_received(:cek_id_member).with(member.id)
        expect(output).to eq(1)
        M_api_db_tambah_post.new.cek_id_member(member.id)
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