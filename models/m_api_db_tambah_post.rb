require "./models/m_koneksi_db"
class M_api_db_tambah_post
    def insert_post_media(id_post, id_media)
        client = M_koneksi_db.new.buat_koneksi_db
        client.query("INSERT INTO tb_post_media (id_post,id_media) values (#{id_post},#{id_media})")
        client.last_id
    end

    def insert_media(lokasi,ext)
        client = M_koneksi_db.new.buat_koneksi_db
        client.query("INSERT INTO tb_media (lokasi,ext) values ('#{lokasi}','#{ext}')")
        client.last_id
    end

    def insert_hashtag_post(id_hashtag, id_post)
        client = M_koneksi_db.new.buat_koneksi_db
        client.query("INSERT INTO tb_hashtag_post (id_hashtag,id_post) values (#{id_hashtag},#{id_post})")
        client.last_id
    end

    def insert_hashtag(hashtag)
        client = M_koneksi_db.new.buat_koneksi_db
        client.query("INSERT INTO tb_hashtag (hashtag) values ('#{hashtag}')")
        client.last_id
    end

    def cek_duplikat_hashtag(id_hashtag, id_post)
        client = M_koneksi_db.new.buat_koneksi_db
        rawData = client.query("SELECT COUNT(id_post) FROM tb_hashtag_post WHERE id_hashtag=#{id_hashtag} AND id_post=#{id_post} LIMIT 1")
        jumlah = 0
        rawData.each do | data |
            jumlah = data["COUNT(id_post)"]
        end
        return jumlah
    end

    def get_id_hashtag(hashtag)
        client = M_koneksi_db.new.buat_koneksi_db
        rawData = client.query("SELECT id FROM tb_hashtag WHERE hashtag='#{hashtag}' LIMIT 1")
        id_hash = 0
        rawData.each do | data |
            if data["id"] > 0
                id_hash = data["id"]
            end
        end
        return id_hash
    end

    def get_hashtag(text)
        daftarhashtag = text.scan /#([a-zA-Z0-9\_]+)(?: |$)/
        hashtags = Array.new
        daftarhashtag.each do | data |
            hashtags.push(data.join)
        end
        return hashtags
    end

    def cek_valid(id_member,text)
        error = {:hasil => false, :pesan => ""}
        if id_member == nil or id_member == ""
            error = {:hasil => true, :pesan => "ID member wajib diisi"}
        elsif text == nil or text == ""
            error = {:hasil => true, :pesan => "Text wajib diisi"}
        elsif text.length > 1000
            error = {:hasil => true, :pesan => "Text maksimal 1000 karakter"}
        end
        return error
    end

    def insert_post(id_member,id_parent_post,text)
        client = M_koneksi_db.new.buat_koneksi_db
        client.query("INSERT INTO tb_post (id_member,id_parent_post,text) values ('#{id_member}','#{id_parent_post}','#{text}')")
        client.last_id
    end
end