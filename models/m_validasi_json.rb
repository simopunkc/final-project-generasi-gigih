class M_validasi_json
    def cek_json?(params)
        error = { :hasil => false, :pesan => "" }
        if params['json'].empty?
            error = {:hasil => true, :pesan => "Parameter kosong"}
        elsif !params['json'].is_a?(JSON)
            error = {:hasil => true, :pesan => "Parameter harus json"}
        else
            param = params['json']
            json = JSON.parse(param)
            error = { :hasil => false, :pesan => json }
        end
        return error
    end
end