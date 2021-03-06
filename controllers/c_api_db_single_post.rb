class C_api_db_single_post
    include C_cek_integer

    def cek_param_request(param)
        id_post = (param.key?(:id)) ? 0 : 1
        error = {:hasil => false, :pesan => ""}
        if id_post == 1
            error = {:hasil => true, :pesan => "Param ID post tidak ditemukan"}
        end
        return error
    end

    def cek_valid(id_post)
        model = M_api_db_single_post.new
        error = {:hasil => false, :pesan => ""}
        if id_post == nil or id_post == ""
            error = {:hasil => true, :pesan => "ID post wajib diisi"}
        elsif cek_integer?(id_post) == false
            error = {:hasil => true, :pesan => "ID post harus integer"}
        elsif model.cek_id_post(id_post) == 0
            error = {:hasil => true, :pesan => "ID post tidak ada di database"}
        end
        return error
    end

    def print_output(single_post)
        view = ERB.new(File.read("./views/v_api_db_single_post.erb"))
        view.result(binding)
    end
end