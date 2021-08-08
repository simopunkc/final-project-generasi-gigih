require "./models/m_koneksi_db"
require "./models/m_validasi_json"
require "./models/m_api_db_tambah_member"

class C_api_db_tambah_member
    def cek_param_request(param)
        respon = 200
        if defined? param["username"] == nil
            respon = 400
        elsif defined? param["email"] == nil
            respon = 400
        elsif defined? param["bio"] == nil
            respon = 400
        end
        return respon
    end

    def proses(params)
        model = M_api_db_tambah_member.new
        error = model.
        error = model.cek_valid(username,email,bio)
    end
end