require "./models/m_koneksi_db"
class M_api_db_single_hashtag
    def get_all_post(id_hashtag)
        client = M_koneksi_db.new.buat_koneksi_db
        rawData = client.query("SELECT id_post FROM tb_hashtag_post WHERE id_hashtag=#{id_hashtag}")
        post_id = Array.new
        rawData.each do | data |
            post_id.push(data["id_post"])
        end
        return post_id
    end
    def get_all_post_comment(id_parent_post)
        client = M_koneksi_db.new.buat_koneksi_db
        rawData = client.query("SELECT id FROM tb_post WHERE id_parent_post=#{id_parent_post} ORDER BY id DESC")
        post_id = Array.new
        rawData.each do | data |
            post_id.push(data["id"])
        end
        return post_id
    end
end