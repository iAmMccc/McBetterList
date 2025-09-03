//
//  File.swift
//  McccBase
//
//  Created by Mccc on 2025/8/22.
//

import Foundation
public protocol BetterNamespaceWrappable {
    associatedtype McccWrapperType
    var mc: McccWrapperType { get }
    static var mc: McccWrapperType.Type { get }
}

public extension BetterNamespaceWrappable {
    var mc: BetterNamespaceWrapper<Self> {
        return BetterNamespaceWrapper(value: self)
    }

    static var mc: BetterNamespaceWrapper<Self>.Type {
        return BetterNamespaceWrapper.self
    }
}

public struct BetterNamespaceWrapper<T> {
    public let wrappedValue: T
    public init(value: T) {
        self.wrappedValue = value
    }
}
