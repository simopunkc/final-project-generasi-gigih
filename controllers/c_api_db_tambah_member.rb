require "./models/m_koneksi_db"
require "./models/m_validasi_json"
require "./models/m_api_db_tambah_member"

class C_api_db_tambah_member
    def proses(params)
        model = M_api_db_tambah_member.new
        error = M_validasi_json.new.cek_json?(params)
        error = model.cek_valid(username,email,bio)
    end
end