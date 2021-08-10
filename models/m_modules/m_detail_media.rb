module M_detail_media
    def get_detail_media(id)
        client=M_koneksi_db.new.buat_koneksi_db
        rawData = client.query("SELECT * FROM tb_media WHERE id = #{id} limit 1")
        media = Array.new
        rawData.each do | data |
            raw = M_raw_media.new(data["id"],data["lokasi"],data["mime"])
            media.push(raw)
        end
        media
    end
end