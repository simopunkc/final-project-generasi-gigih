require "./models/m_koneksi_db"
class M_api_db_trending_hashtag
    def get_trending_hashtag
        client = M_koneksi_db.new.buat_koneksi_db
        rawData = client.query("SELECT id_post FROM tb_hashtag_post ORDER BY id_hashtag DESC LIMIT 5")
        post_id = Array.new
        rawData.each do | data |
            post_id.push(data["id_post"])
        end
        return post_id
    end
end