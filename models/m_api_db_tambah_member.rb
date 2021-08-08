require "./models/m_koneksi_db"
class M_api_db_tambah_member
    def cek_valid(username,email,bio)
        error = {:hasil => false, :pesan => ""}
        if username == nil or username == ""
            error = {:hasil => true, :pesan => "Username wajib diisi"}
        elsif email == nil or email == ""
            error = {:hasil => true, :pesan => "Email wajib diisi"}
        end
        return error
    end

    def insert_member(username,email,bio)
        client = M_koneksi_db.new.buat_koneksi_db
        client.query("INSERT INTO member (username,email,bio) values ('#{username}','#{email}','#{bio}')")
        client.last_id
    end
end