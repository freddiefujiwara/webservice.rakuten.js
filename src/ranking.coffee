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
            .then(
                ((data) ->
                  return data),
                ((data) ->
                    deferred = $.Deferred().resolve
                      Body:
                          ItemRanking:
                              Items:
                                  Item:[]
                      Header:
                          Status: 'Success'
                          Args:
                              Arg:
                                 apiVersion:
                                     content: true
                                     value: "30"
                                 operation:
                                     content: true
                                     value: "ItemRanking"
                                 developerId:
                                     content: true
                                     value: "1084425069581237387"
                                 "User-Agent":
                                     content: true
                                     value: "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/27.0.1453.110 Safari/537.36"
                                 affiliateId:
                                     content: true
                                     value: "0ca3304d.a811038d.0ca3304e.80024f1e"
                                 genreId:
                                     content: false
                                     value: "0"
                                 version:
                                     content: true
                                     value: "2010-08-05"
                          StatusMsg: ''
                    return deferred.promise()
                    )
              )
