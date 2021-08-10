class C_api_db_tambah_post
    include C_cek_integer

    def cek_param_request(param)
        id_member = (param.key?('id_member')) ? 0 : 1
        id_parent_post = (param.key?('id_parent_post')) ? 0 : 1
        text = (param.key?('text')) ? 0 : 1
        media = (param.key?('media')) ? 0 : 1
        error = {:hasil => false, :pesan => ""}
        if id_member == 1
            error = {:hasil => true, :pesan => "Parameter id_member tidak ditemukan"}
        elsif id_parent_post == 1
            error = {:hasil => true, :pesan => "Parameter id_parent_post tidak ditemukan"}
        elsif text == 1
            error = {:hasil => true, :pesan => "Parameter text tidak ditemukan"}
        elsif media == 1
            error = {:hasil => true, :pesan => "Parameter media tidak ditemukan"}
        end
        return error
    end

    def hapus_spesial_character(namafile)
        return namafile.gsub(/(?:[^A-Za-z0-9\-\_\.]+)/,'')
    end

    def create_folder_upload(id_member)
        waktu = DateTime.now
        tgl = waktu.strftime("%Y-%B-%d")
        direktori = 'upload/'+'member'+id_member.to_s+'/'+tgl+'/'
        FileUtils.mkdir_p direktori, :mode => 0777 unless Dir.exist?(direktori)
        return direktori
    end

    def get_hashtag(text)
        daftarhashtag = text.scan /#([a-zA-Z0-9\_]+)(?: |$)/
        hashtags = Array.new
        daftarhashtag.each do | data |
            tag = data.join.downcase
            hashtags.push(tag)
        end
        return hashtags.uniq
    end

    def cek_valid(id_member,id_parent_post,text)
        model = M_api_db_tambah_post.new
        error = {:hasil => false, :pesan => ""}
        if id_member == nil or id_member == ""
            error = {:hasil => true, :pesan => "ID member wajib diisi"}
        elsif cek_integer?(id_member) == false
            error = {:hasil => true, :pesan => "ID member harus integer"}
        elsif model.cek_id_member(id_member) == 0
            error = {:hasil => true, :pesan => "ID member tidak terdaftar"}
        elsif cek_integer?(id_parent_post) == false
            error = {:hasil => true, :pesan => "ID parent post harus integer"}
        elsif text == nil or text == ""
            error = {:hasil => true, :pesan => "Text wajib diisi"}
        elsif text.length > 1000
            error = {:hasil => true, :pesan => "Text maksimal 1000 karakter"}
        end
        return error
    end
end