//
//  Schema.swift
//  SwifQL
//
//  Created by Mihael Isaev on 12.04.2020.
//

import Foundation

@dynamicMemberLookup
public struct Schema<T: AnyTableable> {
    let name: String
    
    public init (_ name: String) {
        self.name = name
    }

    public subscript<V>(dynamicMember keyPath: KeyPath<T, V>) -> SwifQLable {
        guard let k = keyPath as? Keypathable else { return "<keyPath should conform to Keypathable>" }
        return SwifQLPartKeyPath(schema: name, table: k.table, paths: k.paths)
    }
    
    public var table: SwifQLable {
        Path.SchemaWithTable(schema: name, table: T.tableName)
    }
    
    public func column(_ paths: String...) -> Path.SchemaWithTableAndColumn {
        column(paths)
    }
    
    public func column(_ paths: [String]) -> Path.SchemaWithTableAndColumn {
        .init(schema: name, table: T.tableName, paths: paths)
    }
    
    public func `as`(_ alias: String) -> SwifQLTableAlias<T> {
        SwifQLTableAlias(alias, schema: name)
    }
}

//@dynamicMemberLookup
//extension KeyPath where Value: Tableable {
//    public subscript<V>(dynamicMember keyPath: KeyPath<Value, V>) -> String {
//        guard let k = keyPath as? Keypathable else { return "<keyPath should conform to Keypathable>" }
//        return k.fullPath(schema: name, table: T.tableName)
//    }
//}
