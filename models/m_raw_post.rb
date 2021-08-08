class M_raw_post
    attr_accessor :id, :id_member, :id_parent_post, :text, :waktu
    def initialize(id=nil, id_member=nil, id_parent_post=nil, text=nil, waktu=nil)
        @id = id
        @id_member = id_member
        @id_parent_post = id_parent_post
        @text = text
        @waktu = waktu
    end
end