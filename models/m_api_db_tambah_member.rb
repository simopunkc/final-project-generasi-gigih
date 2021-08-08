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

    def cek_valid(username,email,bio)
        error = {:hasil => false, :pesan => ""}
        if username == nil or username == ""
            error = {:hasil => true, :pesan => "Username wajib diisi"}
        elsif email == nil or email == ""
            error = {:hasil => true, :pesan => "Email wajib diisi"}
        elsif cek_duplikat_username(username) == 1
            error = {:hasil => true, :pesan => "Username sudah digunakan"}
        elsif cek_duplikat_email(email) == 1
            error = {:hasil => true, :pesan => "Email sudah digunakan"}
        end
        return error
    end

    def insert_member(username,email,bio)
        client = M_koneksi_db.new.buat_koneksi_db
        client.query("INSERT INTO tb_member (username,email,bio) values ('#{username}','#{email}','#{bio}')")
        client.last_id
    end
end