root = exports ? window class root.Ranking
$    = $ ? require 'jquery'

class root.Ranking
    constructor:(@developerId ,@affiliateId = "") ->
        @baseURL = "http://api.rakuten.co.jp/rws/3.0/json?operation=ItemRanking&version=2010-08-05&affiliateId=#{@affiliateId}&developerId=#{@developerId}"

    findByGenreId:(genreId = 0) ->
        @url = @baseURL + "&genreId=#{genreId}"
        deferred = $.Deferred()
        $.ajax @url,
            type: 'GET'
            dataType: 'json',
            success: deferred.resolve
            error: deferred.reject

        return deferred.promise()
