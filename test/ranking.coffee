should =  require('should')
Ranking = require("../src/ranking").Ranking

describe 'Ranking', ->
    r = null

    before ->
        r = new Ranking("1084425069581237387","0ca3304d.a811038d.0ca3304e.80024f1e")

    it "should be a Ranking object", ->
       r.should.be.a('object')

    it "has properties", ->
       r.should.have.property('developer_id')
       r.developer_id.should.equal("1084425069581237387")
       r.should.have.property('affiliate_id')
       r.affiliate_id.should.equal("0ca3304d.a811038d.0ca3304e.80024f1e")

    it "has base url", ->
       r.base_url.should.equal("http://api.rakuten.co.jp/rws/3.0/json?operation=ItemRanking&version=2010-08-05&affiliateId=0ca3304d.a811038d.0ca3304e.80024f1e&developerId=1084425069581237387")

    it "has find_by_genre_id", (done) ->
       r.should.have.property('find_by_genre_id')
       r.find_by_genre_id.should.be.a('function')
       r.find_by_genre_id().done( (data) ->
           data.should.not.be.empty
           #console.log(data)
           done()
       )
       r.url.should.equal("http://api.rakuten.co.jp/rws/3.0/json?operation=ItemRanking&version=2010-08-05&affiliateId=0ca3304d.a811038d.0ca3304e.80024f1e&developerId=1084425069581237387&genreId=0")
