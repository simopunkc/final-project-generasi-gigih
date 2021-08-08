class M_raw_media
    attr_accessor :id, :lokasi, :ext
    def initialize(id=nil, lokasi=nil, ext=nil)
        @id = id
        @lokasi = lokasi
        @ext = ext
    end
end