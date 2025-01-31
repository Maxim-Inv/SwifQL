import XCTest
@testable import SwifQL

final class WithTests: SwifQLTestCase {
    func testWith() {
        let sql = SwifQL
            .with(.init(Path.Table("Table1"), SwifQL.select(Path.Table("Table2").*).from(Path.Table("Table2"))))
            .select(Path.Table("Table1").*)
            .from(Path.Table("Table1"))
        
        checkAllDialects(sql, pg: """
        WITH "Table1" as (SELECT "Table2".* FROM "Table2") SELECT "Table1".* FROM "Table1"
        """, mySQL: """
        WITH Table1 as (SELECT Table2.* FROM Table2) SELECT Table1.* FROM Table1
        """)
    }
    
    func testWithColumns() {
        struct Table1: Codable, Tableable {}
        
        let sql = SwifQL
            .with(
                .init(Table1.table, SwifQL.select(Table1.table.*).from(Table1.table)),
                .init(Path.Table("Table2"), columns: [Path.Column("hi"), Path.Column("there")], SwifQL.select(Path.Table("Table2").*).from(Path.Table("Table2")))
            )
            .select(Path.Table("Table3").*)
            .from(Path.Table("Table3"))
        
        checkAllDialects(sql, pg: """
        WITH "Table1" as (SELECT "Table1".* FROM "Table1"), "Table2" ("hi", "there") as (SELECT "Table2".* FROM "Table2") SELECT "Table3".* FROM "Table3"
        """, mySQL: """
        WITH Table1 as (SELECT Table1.* FROM Table1), Table2 (hi, there) as (SELECT Table2.* FROM Table2) SELECT Table3.* FROM Table3
        """)
    }
    
    static var allTests = [
        ("testWith", testWith),
        ("testWithColumns", testWithColumns)
    ]
}
