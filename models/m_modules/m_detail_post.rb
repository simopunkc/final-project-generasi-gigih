module M_detail_post
    def get_detail_post(id)
        client=M_koneksi_db.new.buat_koneksi_db
        rawData = client.query("SELECT * FROM tb_post WHERE id = #{id} limit 1")
        post = Array.new
        rawData.each do | data |
            raw = M_raw_post.new(data["id"],data["id_member"],data["id_parent_post"],data["text"],data["waktu"])
            post.push(raw)
        end
        post
    end
end