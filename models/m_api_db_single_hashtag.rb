require "./models/m_modules/m_detail_post"

class M_api_db_single_hashtag
    include M_detail_post

    def get_all_post(id_hashtag)
        client = M_koneksi_db.new.buat_koneksi_db
        rawData = client.query("SELECT id_post FROM tb_hashtag_post WHERE id_hashtag=#{id_hashtag}")
        post_id = Array.new
        rawData.each do | data |
            post_id.push(data["id_post"])
        end
        return post_id
    end

    def cek_id_hashtag(id_hashtag)
        client = M_koneksi_db.new.buat_koneksi_db
        rawData = client.query("SELECT COUNT(id) FROM tb_hashtag WHERE id=#{id_hashtag} LIMIT 1")
        jumlah = 0
        rawData.each do | data |
            jumlah = data["COUNT(id)"]
        end
        return jumlah
    end
end