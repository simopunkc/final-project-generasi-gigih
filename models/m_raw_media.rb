class M_raw_media
    attr_accessor :id, :lokasi, :mime
    def initialize(id=nil, lokasi=nil, mime=nil)
        @id = id
        @lokasi = lokasi
        @mime = mime
    end
end