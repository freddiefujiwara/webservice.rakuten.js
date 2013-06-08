should = require 'should'
sinon  = require 'sinon'
$ = require 'jquery'
Ranking = require("../js-cov/ranking").Ranking

describe 'Ranking', ->
    r = null

    beforeEach ->
        r = new Ranking("1084425069581237387","0ca3304d.a811038d.0ca3304e.80024f1e")

    afterEach ->

    it "should be a Ranking object", ->
       r.should.be.a('object')

    it "has properties", ->
       r.should.have.property('developerId')
       r.developerId.should.equal("1084425069581237387")
       r.should.have.property('affiliateId')
       r.affiliateId.should.equal("0ca3304d.a811038d.0ca3304e.80024f1e")

    it "has base url", ->
       r.baseURL.should.equal("http://api.rakuten.co.jp/rws/3.0/json?operation=ItemRanking&version=2010-08-05&affiliateId=0ca3304d.a811038d.0ca3304e.80024f1e&developerId=1084425069581237387")

    it "has findByGenreId with success pattern", (done) ->
       r.should.have.property('findByGenreId')
       r.findByGenreId.should.be.a('function')
       #test data
       sinon.stub($,'ajax').yieldsTo('success',
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
       )
       r.findByGenreId().done( (data) ->
           should.equal(typeof data , "object")
           should.equal(typeof data.Header , "object")
           should.equal(typeof data.Body , "object")
           should.equal(typeof data.Body.ItemRanking , "object")
           should.equal(typeof data.Body.ItemRanking.Items , "object")
           should.equal(typeof data.Body.ItemRanking.Items.Item , "object")
           should.equal(data.Header.Status , "Success")
           done()
       )
       r.url.should.equal("http://api.rakuten.co.jp/rws/3.0/json?operation=ItemRanking&version=2010-08-05&affiliateId=0ca3304d.a811038d.0ca3304e.80024f1e&developerId=1084425069581237387&genreId=0")
       $.ajax.restore()

    it "has findByGenreId with failure pattern", (done) ->
       #test data
       sinon.stub($,'ajax').yieldsTo('error',
          Body: { }
          Header:
              Status: "ClientError"
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
                          value: ""
                      version:
                          content: true
                          value: "2010-08-05"
              StatusMsg: "genreIdパラメータは6桁以下の数値を指定してください。"
       )
       r.findByGenreId().fail( (data) ->
           should.equal(typeof data , "object")
           should.equal(typeof data.Header , "object")
           should.equal(typeof data.Body , "object")
           should.equal(typeof data.Body.ItemRanking , "undefined")
           should.equal(data.Header.Status , "ClientError")
           done()
       )
       r.url.should.equal("http://api.rakuten.co.jp/rws/3.0/json?operation=ItemRanking&version=2010-08-05&affiliateId=0ca3304d.a811038d.0ca3304e.80024f1e&developerId=1084425069581237387&genreId=0")
       $.ajax.restore()
