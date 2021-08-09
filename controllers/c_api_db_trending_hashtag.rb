class C_api_db_trending_hashtag
    def print_output(trending_hashtag)
        view = ERB.new(File.read("./views/v_api_db_trending_hashtag.erb"))
        view.result(binding)
    end
end