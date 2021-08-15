class M_api_db_search_hashtag
    def get_id_hashtag(nama_hashtag)
        client = M_koneksi_db.new.buat_koneksi_db
        rawData = client.query("SELECT id FROM tb_hashtag WHERE hashtag='#{nama_hashtag}' LIMIT 1")
        hashtag_id = 0
        rawData.each do | data |
            hashtag_id=data["id"]
        end
        return hashtag_id
    end
end