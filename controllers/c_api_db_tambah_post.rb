require 'fileutils'
require 'date'
require "./models/m_koneksi_db"

class C_api_db_tambah_post
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

    def create_folder_upload
        waktu = DateTime.now
        tgl = waktu.strftime("%Y-%B-%d")
        direktori = 'upload/'+tgl
        FileUtils.mkdir_p direktori, :mode => 0777 unless Dir.exist?(direktori)
        return direktori
    end

    def get_hashtag(text)
        daftarhashtag = text.scan /#([a-zA-Z0-9\_]+)(?: |$)/
        hashtags = Array.new
        daftarhashtag.each do | data |
            hashtags.push(data.join)
        end
        return hashtags
    end

    def cek_valid(id_member,text)
        error = {:hasil => false, :pesan => ""}
        if id_member == nil or id_member == ""
            error = {:hasil => true, :pesan => "ID member wajib diisi"}
        elsif text == nil or text == ""
            error = {:hasil => true, :pesan => "Text wajib diisi"}
        elsif text.length > 1000
            error = {:hasil => true, :pesan => "Text maksimal 1000 karakter"}
        end
        return error
    end
end