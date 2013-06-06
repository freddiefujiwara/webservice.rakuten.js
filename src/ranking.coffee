root = exports ? window class root.Ranking

class root.Ranking
    constructor:(@developer_id ,@affiliate_id = "") ->
        @base_url = "http://api.rakuten.co.jp/rws/3.0/json?operation=ItemRanking&version=2010-08-05&affiliateId=#{@affiliate_id}&developerId=#{@developer_id}"
        @url     = ""

    find_by_genre_id:(genre_id = 0) ->
        @url = @base_url + "&genreId=#{genre_id}"
