class M_raw_member
    attr_accessor :id, :username, :email, :bio
    def initialize(id=nil, username=nil, email=nil, bio=nil)
        @id = id
        @username = username
        @email = email
        @bio = bio
    end
end