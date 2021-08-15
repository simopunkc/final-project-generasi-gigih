class C_api_db_search_hashtag
    include C_cek_integer

    def cek_param_request(param)
        nama_hashtag = (param.key?(:name)) ? 0 : 1
        error = {:hasil => false, :pesan => ""}
        if nama_hashtag == 1
            error = {:hasil => true, :pesan => "Nama hashtag tidak ditemukan"}
        end
        return error
    end

    def cek_valid(nama_hashtag)
        error = {:hasil => false, :pesan => ""}
        if nama_hashtag == nil or nama_hashtag == ""
            error = {:hasil => true, :pesan => "Nama hashtag wajib diisi"}
        elsif cek_integer?(nama_hashtag) == true
            error = {:hasil => true, :pesan => "Nama hashtag harus string"}
        end
        return error
    end

    def print_output(tag)
        view = ERB.new(File.read("./views/v_api_db_search_hashtag.erb"))
        view.result(binding)
    end
end