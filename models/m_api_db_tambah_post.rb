require "./models/m_koneksi_db"
class M_api_db_tambah_post
    def cek_hashtag(text)
        return false
    end

    def cek_valid(id_member,text)
        error = {:hasil => false, :pesan => ""}
        if id_member == nil or id_member == ""
            error = {:hasil => true, :pesan => "ID member wajib diisi"}
        elsif text == nil or text == ""
            error = {:hasil => true, :pesan => "Text wajib diisi"}
        elsif text.length > 1000
            error = {:hasil => true, :pesan => "Text maksimal 1000 karakter"}
        elsif !cek_hashtag(text)
            error = {:hasil => true, :pesan => "Hashtag wajib diisi"}
        end
        return error
    end

    def insert_post(id_member,id_parent_post,text)
        client = M_koneksi_db.new.buat_koneksi_db
        client.query("INSERT INTO post (id_member,id_parent_post,text) values ('#{id_member}','#{id_parent_post}','#{text}')")
        client.last_id
    end
end