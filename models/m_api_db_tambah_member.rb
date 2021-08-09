require "./models/m_koneksi_db"
class M_api_db_tambah_member
    def cek_duplikat_username(username)
        client = M_koneksi_db.new.buat_koneksi_db
        rawData = client.query("SELECT COUNT(id) FROM tb_member WHERE username='#{username}' LIMIT 1")
        jumlah = 0
        rawData.each do | data |
            jumlah = data["COUNT(id)"]
        end
        return jumlah
    end

    def cek_duplikat_email(email)
        client = M_koneksi_db.new.buat_koneksi_db
        rawData = client.query("SELECT COUNT(id) FROM tb_member WHERE email='#{email}' LIMIT 1")
        jumlah = 0
        rawData.each do | data |
            jumlah = data["COUNT(id)"]
        end
        return jumlah
    end

    def insert_member(username,email,bio)
        client = M_koneksi_db.new.buat_koneksi_db
        client.query("INSERT INTO tb_member (username,email,bio) values ('#{username}','#{email}','#{bio}')")
        client.last_id
    end
end