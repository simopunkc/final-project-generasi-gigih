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
        model = M_api_db_single_hashtag.new
        error = {:hasil => false, :pesan => ""}
        if id_hashtag == nil or id_hashtag == ""
            error = {:hasil => true, :pesan => "ID hashtag wajib diisi"}
        elsif cek_integer?(id_hashtag) == false
            error = {:hasil => true, :pesan => "ID hashtag harus integer"}
        elsif model.cek_id_hashtag(id_hashtag) == 0
            error = {:hasil => true, :pesan => "ID hashtag tidak ada di database"}
        end
        return error
    end

    def print_output(kumpul_post)
        view = ERB.new(File.read("./views/v_api_db_single_hashtag.erb"))
        view.result(binding)
    end
end