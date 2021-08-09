module M_detail_hashtag
    def get_detail_hashtag(id)
        client=M_koneksi_db.new.buat_koneksi_db
        rawData = client.query("SELECT * FROM tb_hashtag WHERE id = #{id} limit 1")
        hashtag = Array.new
        rawData.each do | data |
            raw = M_raw_hashtag.new(data["id"],data["hashtag"])
            hashtag.push(raw)
        end
        hashtag
    end
end