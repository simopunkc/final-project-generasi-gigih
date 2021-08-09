require "./models/m_modules/m_detail_post"

class M_api_db_single_post
    include M_detail_post
    
    def get_all_post_comment(id_post)
        client = M_koneksi_db.new.buat_koneksi_db
        rawData = client.query("SELECT id FROM tb_post WHERE id_parent_post=#{id_post} ORDER BY id DESC")
        post_id = Array.new
        rawData.each do | data |
            post_id.push(data["id"])
        end
        return post_id
    end

    def cek_id_post(id_post)
        client = M_koneksi_db.new.buat_koneksi_db
        rawData = client.query("SELECT COUNT(id) FROM tb_post WHERE id=#{id_post} LIMIT 1")
        jumlah = 0
        rawData.each do | data |
            jumlah = data["COUNT(id)"]
        end
        return jumlah
    end
end