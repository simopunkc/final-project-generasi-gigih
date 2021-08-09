require "./controllers/c_modules/c_cek_integer"

class C_api_db_single_hashtag
    include C_cek_integer

    def cek_param_request(param)
        id_hashtag = (param.key?(:id)) ? 0 : 1
        error = {:hasil => false, :pesan => ""}
        if id_hashtag == 1
            error = {:hasil => true, :pesan => "ID hashtag tidak ditemukan"}
        end
        return error
    end

    def cek_valid(id_hashtag)
        error = {:hasil => false, :pesan => ""}
        if id_hashtag == nil or id_hashtag == ""
            error = {:hasil => true, :pesan => "ID hashtag wajib diisi"}
        elsif cek_integer?(id_hashtag) == false
            error = {:hasil => true, :pesan => "ID hashtag harus integer"}
        end
        return error
    end
end