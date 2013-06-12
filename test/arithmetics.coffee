should = require 'should'
Arithmetics = require("../js/arithmetics")

describe 'Arithmetics', ->

    beforeEach ->

    afterEach ->

    it "should have a parse method", ->
       Arithmetics.parse.should.be.a('function')

    it "should calculate arithmetics syntax", ->
       Arithmetics.parse('1+1').should.equal(2)
       Arithmetics.parse('3*5').should.equal(15)
       Arithmetics.parse('15-5').should.equal(10)
       Arithmetics.parse('15/5').should.equal(3)
       Arithmetics.parse('110').should.equal(110)
       Arithmetics.parse('(1+2)*3').should.equal(9)
       Arithmetics.parse('3*4/3').should.equal(4)
       Arithmetics.parse('3*(4/3)').should.equal(4)
