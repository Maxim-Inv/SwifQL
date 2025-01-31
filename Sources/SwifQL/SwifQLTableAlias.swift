//
//  SwifQLTableAlias.swift
//  SwifQL
//
//  Created by Mihael Isaev on 11/11/2018.
//

import Foundation

protocol SwifQLTableAliasable {
    var alias: String { get }
}

@dynamicMemberLookup
public class SwifQLTableAlias<M: Decodable>: SwifQLable, SwifQLTableAliasable {
    public typealias Model = M
    
    public var parts: [SwifQLPart] {
        [SwifQLPartTable(schema: schema, table: alias)]
    }
    
    public var table: SwifQLable {
        SwifQLableParts(parts: SwifQLPartTableWithAlias(schema: schema, table: name, alias: alias))
    }
    
    var name: String {
        if let mmm = M.self as? AnyTableable.Type {
            return mmm.tableName
        }
        return String(describing: M.self)
    }
    
    var schema: String?
    
    var alias: String
    
    public init(_ alias: String, schema: String?) {
        self.alias = alias
        self.schema = schema ?? (Model.self as? Schemable.Type)?.schemaName
    }
    
    public func column(_ paths: String...) -> Path.TableWithColumn {
        Path.Table(alias).column(paths)
    }
    
    public subscript<V>(dynamicMember keyPath: KeyPath<Model, V>) -> SwifQLable {
        guard let k = keyPath as? Keypathable else { return "<keyPath should conform to Keypathable>" }
        return Path.Table(alias).column(k.paths)
    }
}

postfix operator *
postfix public func *<T: Decodable>(table: SwifQLTableAlias<T>) -> SwifQLable {
    var parts: [SwifQLPart] = []
    parts.append(SwifQLPartTable(table.alias))
    parts.append(o: .custom(".*"))
    parts.append(o: .space)
    return SwifQLableParts(parts: parts)
}
postfix public func *(table: AnyTableable.Type) -> SwifQLable {
    var parts: [SwifQLPart] = []
    parts.append(SwifQLPartTable(table.tableName))
    parts.append(o: .custom(".*"))
    parts.append(o: .space)
    return SwifQLableParts(parts: parts)
}

//MARK: Decodable extension

extension Decodable {
    public static func `as`(_ alias: String) -> SwifQLTableAlias<Self> {
        SwifQLTableAlias(alias, schema: nil)
    }
}

//MARK: AliasedKeyPath

public class AliasedKeyPath<K, T, V> where K: KeyPath<T, V>, K: Keypathable, T: Decodable {
    var alias: String
    var kp: K
    init(_ alias: String, _ kp: K) {
        self.alias = alias
        self.kp = kp
    }
}

extension AliasedKeyPath: SwifQLKeyPathable {
    public var schema: String? { (AModel.self as? Schemable.Type)?.schemaName }
    public var table: String? { alias }
    public var paths: [String] { kp.paths }
}

extension AliasedKeyPath: SwifQLable {
    public var parts: [SwifQLPart] {
        if let kp = self.originalKeyPath as? FluentKitFieldable {
            return [SwifQLPartKeyPath(table: table, paths: [kp.key])]
        }
        return [SwifQLPartKeyPath(table: table, paths: paths)]
    }
}

extension AliasedKeyPath: SwifQLUniversalKeyPath, SwifQLUniversalKeyPathSimple {
    public typealias AType = V
    public typealias AModel = T
    public typealias ARoot = AliasedKeyPath
    
    public var path: String { kp.shortPath }
    public var lastPath: String { kp.lastPath }
    public var originalKeyPath: KeyPath<T, V> { kp }
}
