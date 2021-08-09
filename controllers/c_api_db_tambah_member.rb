class C_api_db_tambah_member
    def cek_param_request(param)
        username = (param.key?('username')) ? 0 : 1
        email = (param.key?('email')) ? 0 : 1
        bio = (param.key?('bio')) ? 0 : 1
        error = {:hasil => false, :pesan => ""}
        if username == 1
            error = {:hasil => true, :pesan => "Parameter username tidak ditemukan"}
        elsif email == 1
            error = {:hasil => true, :pesan => "Parameter email tidak ditemukan"}
        elsif bio == 1
            error = {:hasil => true, :pesan => "Parameter bio tidak ditemukan"}
        end
        return error
    end

    def cek_valid(username,email)
        model = M_api_db_tambah_member.new
        error = {:hasil => false, :pesan => ""}
        if username == nil or username == ""
            error = {:hasil => true, :pesan => "Username wajib diisi"}
        elsif email == nil or email == ""
            error = {:hasil => true, :pesan => "Email wajib diisi"}
        elsif model.cek_duplikat_username(username) == 1
            error = {:hasil => true, :pesan => "Username sudah digunakan"}
        elsif model.cek_duplikat_email(email) == 1
            error = {:hasil => true, :pesan => "Email sudah digunakan"}
        end
        return error
    end
end