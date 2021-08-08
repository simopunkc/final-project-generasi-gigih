require 'fileutils'
require 'date'
require "./models/m_koneksi_db"

class C_api_db_tambah_post
    def create_folder_upload
        waktu = DateTime.now
        tgl = waktu.strftime("%Y-%B-%d")
        direktori = 'upload/'+tgl
        FileUtils.mkdir_p direktori, :mode => 0777 unless Dir.exist?(direktori)
        return direktori
    end
end