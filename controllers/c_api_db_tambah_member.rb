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
end