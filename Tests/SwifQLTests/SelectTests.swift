import XCTest
@testable import SwifQL

final class SelectTests: SwifQLTestCase {
    func testSelect() {
        checkAllDialects(SwifQL.select(), pg: "SELECT ", mySQL: "SELECT ")
        checkAllDialects(SwifQL.select, pg: "SELECT", mySQL: "SELECT")
    }
    
    func testSelectString() {
        checkAllDialects(SwifQL.select("hello"), pg: "SELECT 'hello'", mySQL: "SELECT 'hello'")
    }
    
    func testSelectInt() {
        checkAllDialects(SwifQL.select(1), pg: "SELECT 1", mySQL: "SELECT 1")
    }
    
    func testSelectDouble() {
        checkAllDialects(SwifQL.select(1.234), pg: "SELECT 1.234", mySQL: "SELECT 1.234")
    }
    
    func testSelectSeveralSimpleValues() {
        checkAllDialects(SwifQL.select("hello", 1, 1.234), pg: "SELECT 'hello', 1, 1.234", mySQL: "SELECT 'hello', 1, 1.234")
    }
    
    func testSelectColumn() {
        checkAllDialects(SwifQL.select(Path.Column("id")), pg: """
            SELECT "id"
            """, mySQL: """
            SELECT id
            """)
    }
    
    func testSelectColumnWithTable() {
        checkAllDialects(SwifQL.select(Path.Table("CarBrands").column("id")), pg: """
            SELECT "CarBrands"."id"
            """, mySQL: """
            SELECT CarBrands.id
            """)
    }
    
    func testSelectColumnWithTableAndSchema() {
        checkAllDialects(SwifQL.select(Path.Schema("test").table("CarBrands").column("id")), pg: """
            SELECT "test"."CarBrands"."id"
            """, mySQL: """
            SELECT test.CarBrands.id
            """)
    }
    
    func testSelectColumnWithoutTable() {
        checkAllDialects(SwifQL.select(Path.Column("id")), pg: """
            SELECT "id"
            """, mySQL: """
            SELECT id
            """)
    }
    
    func testSelectCarBrands() {
        checkAllDialects(SwifQL.select(CarBrands.column("id")), pg: """
            SELECT "CarBrands"."id"
            """, mySQL: """
            SELECT CarBrands.id
            """)
    }
    
    func testSelectSchemableCarBrands() {
        checkAllDialects(SwifQL.select(SchemableCarBrands.column("id")), pg: """
            SELECT "public"."CarBrands"."id"
            """, mySQL: """
            SELECT public.CarBrands.id
            """)
    }
    
    func testSelectCarBrandsInCustomSchema() {
        let cb = Schema<CarBrands>("hello")
        checkAllDialects(SwifQL.select(cb.column("id")), pg: """
            SELECT "hello"."CarBrands"."id"
            """, mySQL: """
            SELECT hello.CarBrands.id
            """)
    }
    
    func testSelectCarBrandsSeveralFields() {
        checkAllDialects(SwifQL.select(CarBrands.column("id"), CarBrands.column("name")), pg: """
            SELECT "CarBrands"."id", "CarBrands"."name"
            """, mySQL: """
            SELECT CarBrands.id, CarBrands.name
            """)
    }
    
    func testSelectCarBrandsWithAlias() {
        checkAllDialects(SwifQL.select(cb.column("id")), pg: """
            SELECT "cb"."id"
            """, mySQL: """
            SELECT cb.id
            """)
    }
    
    func testSelectCarBrandsWithAliasSeveralFields() {
        checkAllDialects(SwifQL.select(cb.column("id"), cb.column("name")), pg: """
            SELECT "cb"."id", "cb"."name"
            """, mySQL: """
            SELECT cb.id, cb.name
            """)
    }
    
    func testSelectCarBrandsSeveralFieldsMixed() {
        checkAllDialects(SwifQL.select(CarBrands.column("id"), cb.column("name"), CarBrands.column("createdAt")), pg: """
            SELECT "CarBrands"."id", "cb"."name", "CarBrands"."createdAt"
            """, mySQL: """
            SELECT CarBrands.id, cb.name, CarBrands.createdAt
            """)
    }
    
    //MARK: PostgreSQL Functions
    
    func testSelectFnAbs() {
        checkAllDialects(SwifQL.select(Fn.abs(1)), pg: "SELECT abs(1)", mySQL: "SELECT abs(1)")
    }
    
    func testSelectFnAvg() {
        checkAllDialects(SwifQL.select(Fn.avg(1)), pg: "SELECT avg(1)", mySQL: "SELECT avg(1)")
    }
    
    func testSelectFnBitLength() {
        checkAllDialects(SwifQL.select(Fn.bit_length("hello")), pg: "SELECT bit_length('hello')", mySQL: "SELECT bit_length('hello')")
    }
    
    func testSelectFnBtrim() {
        checkAllDialects(SwifQL.select(Fn.btrim("hello", "ll")), pg: "SELECT btrim('hello', 'll')", mySQL: "SELECT btrim('hello', 'll')")
    }
    
    func testSelectFnCeil() {
        checkAllDialects(SwifQL.select(Fn.ceil(1.5)), pg: "SELECT ceil(1.5)", mySQL: "SELECT ceil(1.5)")
    }
    
    func testSelectFnCeiling() {
        checkAllDialects(SwifQL.select(Fn.ceiling(1.5)), pg: "SELECT ceiling(1.5)", mySQL: "SELECT ceiling(1.5)")
    }
    
    func testSelectFnCharLength() {
        checkAllDialects(SwifQL.select(Fn.char_length("hello")), pg: "SELECT char_length('hello')", mySQL: "SELECT char_length('hello')")
    }
    
    func testSelectFnCharacter_length() {
        checkAllDialects(SwifQL.select(Fn.character_length("hello")), pg: "SELECT character_length('hello')", mySQL: "SELECT character_length('hello')")
    }
    
    func testSelectFnInitcap() {
        checkAllDialects(SwifQL.select(Fn.initcap("hello")), pg: "SELECT initcap('hello')", mySQL: "SELECT initcap('hello')")
    }
    
    func testSelectFnLength() {
        checkAllDialects(SwifQL.select(Fn.length("hello")), pg: "SELECT length('hello')", mySQL: "SELECT length('hello')")
    }
    
    func testSelectFnLower() {
        checkAllDialects(SwifQL.select(Fn.lower("hello")), pg: "SELECT lower('hello')", mySQL: "SELECT lower('hello')")
    }
    
    func testSelectFnLpad() {
        checkAllDialects(SwifQL.select(Fn.lpad("hello", 3, "lo")), pg: "SELECT lpad('hello', 3, 'lo')", mySQL: "SELECT lpad('hello', 3, 'lo')")
    }
    
    func testSelectFnLtrim() {
        checkAllDialects(SwifQL.select(Fn.ltrim("hello", "he")), pg: "SELECT ltrim('hello', 'he')", mySQL: "SELECT ltrim('hello', 'he')")
    }
    
    func testSelectFnPosition() {
        checkAllDialects(SwifQL.select(Fn.position("el", in: "hello")), pg: "SELECT position('el' IN 'hello')", mySQL: "SELECT position('el' IN 'hello')")
    }
    
    func testSelectFnRepeat() {
        checkAllDialects(SwifQL.select(Fn.repeat("hello", 2)), pg: "SELECT repeat('hello', 2)", mySQL: "SELECT repeat('hello', 2)")
    }
    
    func testSelectFnReplace() {
        checkAllDialects(SwifQL.select(Fn.replace("hello", "el", "ol")), pg: "SELECT replace('hello', 'el', 'ol')", mySQL: "SELECT replace('hello', 'el', 'ol')")
    }
    
    func testSelectFnRpad() {
        checkAllDialects(SwifQL.select(Fn.rpad("hello", 2, "ho")), pg: "SELECT rpad('hello', 2, 'ho')", mySQL: "SELECT rpad('hello', 2, 'ho')")
    }
    
    func testSelectFnRtrim() {
        checkAllDialects(SwifQL.select(Fn.rtrim(" hello ", " ")), pg: "SELECT rtrim(' hello ', ' ')", mySQL: "SELECT rtrim(' hello ', ' ')")
    }
    
    func testSelectFnStrpos() {
        checkAllDialects(SwifQL.select(Fn.strpos("hello", "ll")), pg: "SELECT strpos('hello', 'll')", mySQL: "SELECT strpos('hello', 'll')")
    }
    
    func testSelectFnSubstring() {
        checkAllDialects(SwifQL.select(Fn.substring("hello", from: 1)), pg: "SELECT substring('hello' FROM 1)", mySQL: "SELECT substring('hello' FROM 1)")
        checkAllDialects(SwifQL.select(Fn.substring("hello", for: 4)), pg: "SELECT substring('hello' FOR 4)", mySQL: "SELECT substring('hello' FOR 4)")
        checkAllDialects(SwifQL.select(Fn.substring("hello", from: 1, for: 4)), pg: "SELECT substring('hello' FROM 1 FOR 4)", mySQL: "SELECT substring('hello' FROM 1 FOR 4)")
    }
    
    func testSelectFnTranslate() {
        checkAllDialects(SwifQL.select(Fn.translate("hola", "hola", "hello")), pg: "SELECT translate('hola', 'hola', 'hello')", mySQL: "SELECT translate('hola', 'hola', 'hello')")
    }
    
    func testSelectFnLTrim() {
        checkAllDialects(SwifQL.select(Fn.ltrim("hello", "he")), pg: "SELECT ltrim('hello', 'he')", mySQL: "SELECT ltrim('hello', 'he')")
    }
    
    func testSelectFnUpper() {
        checkAllDialects(SwifQL.select(Fn.upper("hello")), pg: "SELECT upper('hello')", mySQL: "SELECT upper('hello')")
    }
    
    func testSelectFnCount() {
        checkAllDialects(SwifQL.select(Fn.count(CarBrands.column("id"))), pg: """
            SELECT count("CarBrands"."id")
            """, mySQL: """
            SELECT count(CarBrands.id)
            """)
        checkAllDialects(SwifQL.select(Fn.count(cb.column("id"))), pg: """
            SELECT count("cb"."id")
            """, mySQL: """
            SELECT count(cb.id)
            """)
    }
    
    func testSelectFnDiv() {
        checkAllDialects(SwifQL.select(Fn.div(12, 4)), pg: "SELECT div(12, 4)", mySQL: "SELECT div(12, 4)")
    }
    
    func testSelectFnExp() {
        checkAllDialects(SwifQL.select(Fn.exp(12, 4)), pg: "SELECT exp(12, 4)", mySQL: "SELECT exp(12, 4)")
    }
    
    func testSelectFnFloor() {
        checkAllDialects(SwifQL.select(Fn.floor(12)), pg: "SELECT floor(12)", mySQL: "SELECT floor(12)")
    }
    
    func testSelectFnMax() {
        checkAllDialects(SwifQL.select(Fn.max(CarBrands.column("id"))), pg: """
            SELECT max("CarBrands"."id")
            """, mySQL: """
            SELECT max(CarBrands.id)
            """)
        checkAllDialects(SwifQL.select(Fn.max(cb.column("id"))), pg: """
            SELECT max("cb"."id")
            """, mySQL: """
            SELECT max(cb.id)
            """)
    }
    
    func testSelectFnMin() {
        checkAllDialects(SwifQL.select(Fn.min(CarBrands.column("id"))), pg: """
            SELECT min("CarBrands"."id")
            """, mySQL: """
            SELECT min(CarBrands.id)
            """)
        checkAllDialects(SwifQL.select(Fn.min(cb.column("id"))), pg: """
            SELECT min("cb"."id")
            """, mySQL: """
            SELECT min(cb.id)
            """)
    }
    
    func testSelectFnMod() {
        checkAllDialects(SwifQL.select(Fn.mod(12, 4)), pg: "SELECT mod(12, 4)", mySQL: "SELECT mod(12, 4)")
    }
    
    func testSelectFnPower() {
        checkAllDialects(SwifQL.select(Fn.power(12, 4)), pg: "SELECT power(12, 4)", mySQL: "SELECT power(12, 4)")
    }
    
    func testSelectFnRandom() {
        checkAllDialects(SwifQL.select(Fn.random()), pg: "SELECT random()", mySQL: "SELECT random()")
    }
    
    func testSelectFnRound() {
        checkAllDialects(SwifQL.select(Fn.round(12.43)), pg: "SELECT round(12.43)", mySQL: "SELECT round(12.43)")
        checkAllDialects(SwifQL.select(Fn.round(12.43, 1)), pg: "SELECT round(12.43, 1)", mySQL: "SELECT round(12.43, 1)")
    }
    
    func testSelectFnSetSeed() {
        checkAllDialects(SwifQL.select(Fn.setseed(12)), pg: "SELECT setseed(12)", mySQL: "SELECT setseed(12)")
    }
    
    func testSelectFnSign() {
        checkAllDialects(SwifQL.select(Fn.sign(12)), pg: "SELECT sign(12)", mySQL: "SELECT sign(12)")
    }
    
    func testSelectFnSqrt() {
        checkAllDialects(SwifQL.select(Fn.sqrt(16)), pg: "SELECT sqrt(16)", mySQL: "SELECT sqrt(16)")
    }
    
    func testSelectFnSum() {
        checkAllDialects(SwifQL.select(Fn.sum(CarBrands.column("id"))), pg: """
            SELECT sum("CarBrands"."id")
            """, mySQL: """
            SELECT sum(CarBrands.id)
            """)
        checkAllDialects(SwifQL.select(Fn.sum(cb.column("id"))), pg: """
            SELECT sum("cb"."id")
            """, mySQL: """
            SELECT sum(cb.id)
            """)
    }

    func testSelectFnStringAgg() {
        checkAllDialects(SwifQL.select(Fn.string_agg(CarBrands.column("name"), ", ")), pg: """
            SELECT string_agg("CarBrands"."name", ', ')
            """, mySQL: """
            SELECT string_agg(CarBrands.name, ', ')
            """)
    }

    func testSelectFnRegexpReplace() {
        checkAllDialects(SwifQL.select(Fn.regexp_replace("/full/path/to/filename", "^.+/", "")), pg: """
            SELECT regexp_replace('/full/path/to/filename', '^.+/', '')
            """, mySQL: """
            SELECT regexp_replace('/full/path/to/filename', '^.+/', '')
            """)
    }
    
    // MARK: - SELECT with alias in select params
    
    func testSelectWithAliasInSelectParams() {
        let query = SwifQL.select("hello", =>"aaa").from(|SwifQL.select(CarBrands.column("name")).from(CarBrands.table))| => "aaa"
        checkAllDialects(query, pg: """
        SELECT 'hello', "aaa" FROM (SELECT "CarBrands"."name" FROM "CarBrands") as "aaa"
        """, mySQL: """
        SELECT 'hello', aaa FROM (SELECT CarBrands.name FROM CarBrands) as aaa
        """)
    }
    
    static var allTests = [
        ("testPureSelect", testSelect),
        ("testSimpleString", testSelectString),
        ("testSelectInt", testSelectInt),
        ("testSelectDouble", testSelectDouble),
        ("testSelectSeveralSimpleValues", testSelectSeveralSimpleValues),
        ("testSelectColumn", testSelectColumn),
        ("testSelectColumnWithTable", testSelectColumnWithTable),
        ("testSelectCarBrands", testSelectCarBrands),
        ("testSelectCarBrandsSeveralFields", testSelectCarBrandsSeveralFields),
        ("testSelectCarBrandsWithAlias", testSelectCarBrandsWithAlias),
        ("testSelectCarBrandsWithAliasSeveralFields", testSelectCarBrandsWithAliasSeveralFields),
        ("testSelectCarBrandsSeveralFieldsMixed", testSelectCarBrandsSeveralFieldsMixed),
        ("testSelectFnAvg", testSelectFnAvg),
        ("testSelectFnBitLength", testSelectFnBitLength),
        ("testSelectFnBtrim", testSelectFnBtrim),
        ("testSelectFnCeil", testSelectFnCeil),
        ("testSelectFnCeiling", testSelectFnCeiling),
        ("testSelectFnCharLength", testSelectFnCharLength),
        ("testSelectFnCharacter_length", testSelectFnCharacter_length),
        ("testSelectFnInitcap", testSelectFnInitcap),
        ("testSelectFnLength", testSelectFnLength),
        ("testSelectFnLower", testSelectFnLower),
        ("testSelectFnLpad", testSelectFnLpad),
        ("testSelectFnLtrim", testSelectFnLtrim),
        ("testSelectFnPosition", testSelectFnPosition),
        ("testSelectFnRepeat", testSelectFnRepeat),
        ("testSelectFnReplace", testSelectFnReplace),
        ("testSelectFnRpad", testSelectFnRpad),
        ("testSelectFnRtrim", testSelectFnRtrim),
        ("testSelectFnStrpos", testSelectFnStrpos),
        ("testSelectFnSubstring", testSelectFnSubstring),
        ("testSelectFnTranslate", testSelectFnTranslate),
        ("testSelectFnLTrim", testSelectFnLTrim),
        ("testSelectFnUpper", testSelectFnUpper),
        ("testSelectFnCount", testSelectFnCount),
        ("testSelectFnDiv", testSelectFnDiv),
        ("testSelectFnExp", testSelectFnExp),
        ("testSelectFnFloor", testSelectFnFloor),
        ("testSelectFnMax", testSelectFnMax),
        ("testSelectFnMin", testSelectFnMin),
        ("testSelectFnMod", testSelectFnMod),
        ("testSelectFnPower", testSelectFnPower),
        ("testSelectFnRandom", testSelectFnRandom),
        ("testSelectFnRound", testSelectFnRound),
        ("testSelectFnSetSeed", testSelectFnSetSeed),
        ("testSelectFnSign", testSelectFnSign),
        ("testSelectFnSqrt", testSelectFnSqrt),
        ("testSelectFnSum", testSelectFnSum),
        ("testSelectFnStringAgg", testSelectFnStringAgg),
        ("testSelectFnRegexpReplace", testSelectFnRegexpReplace),
        ("testSelectWithAliasInSelectParams", testSelectWithAliasInSelectParams)
    ]
}
