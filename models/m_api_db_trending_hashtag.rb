class M_api_db_trending_hashtag
    def get_trending_hashtag
        client = M_koneksi_db.new.buat_koneksi_db
        rawData = client.query("SELECT DISTINCT tb_hashtag_post.id_hashtag as id_hashtag, tb_post.waktu as waktu FROM tb_hashtag_post LEFT JOIN tb_post ON tb_hashtag_post.id_post = tb_post.id WHERE waktu > (NOW() - INTERVAL 24 HOUR) GROUP BY tb_hashtag_post.id_hashtag ORDER BY COUNT(tb_hashtag_post.id_hashtag) DESC LIMIT 5")
        post_id = Array.new
        rawData.each do | data |
            post_id.push(data["id_hashtag"])
        end
        return post_id
    end
end