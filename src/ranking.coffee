"use strict"
root = exports ? window
$ = $ ? require 'jquery'

class root.Ranking
    constructor:(@developerId ,@affiliateId = "") ->
        @baseURL = "http://api.rakuten.co.jp/rws/3.0/json"
        @baseURL+= "?operation=ItemRanking&version=2010-08-05"
        @baseURL+= "&affiliateId=#{@affiliateId}"
        @baseURL+= "&developerId=#{@developerId}"
            

    findByGenreId:(genreId = 0) ->
        @url = @baseURL + "&genreId=#{genreId}"
        deferred = $.Deferred()
        $.ajax @url,
            type: 'GET'
            dataType: 'json',
            success: deferred.resolve
            error: deferred.reject

        return deferred.promise()
