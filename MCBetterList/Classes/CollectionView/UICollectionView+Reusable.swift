//
//  UICollectionView+Extension.swift
//  
//
//  Created by Mccc on 2020/6/11.
//


import UIKit

extension UICollectionView: BetterNamespaceWrappable { }

extension BetterNamespaceWrapper where T == UICollectionView {
    
    /// UICollectionView初始化方法
    /// - Parameters:
    ///   - cells: 要注册的Cell, 数组类型, 例如：[UICollectionViewCell.self]
    ///   - headers: 要注册的sectionHeaders,数组类型，例如：[UICollectionReusableView.self]
    ///   - footers: 要注册的sectionFooters,数组类型，例如：[UICollectionReusableView.self]
    ///   - delegate: 设置代理
    ///   - layout: UICollectionViewFlowLayout
    public static func make<CellType: UICollectionViewCell,
                            HeaderType: UICollectionReusableView,
                            FooterType: UICollectionReusableView>(
        registerCells cells: [CellType.Type],
        registerHeaders headers: [HeaderType.Type]? = nil,
        registerFooters footers: [FooterType.Type]? = nil,
        delegate: UICollectionViewDelegate & UICollectionViewDataSource,
        layout: UICollectionViewFlowLayout
    ) -> UICollectionView {
        
        let co = UICollectionView(frame: .zero, collectionViewLayout: layout)
        co.delegate = delegate
        co.dataSource = delegate
        co.backgroundColor = .white
        
        // 注册 cell
        for item in cells { co.mc.registerCell(item) }
        
        // 注册 header
        if let temp = headers {
            for item in temp { co.mc.registerSectionHeader(item) }
        }
        
        // 注册 footer
        if let temp = footers {
            for item in temp { co.mc.registerSectionFooter(item) }
        }
        
        return co
    }
}

extension BetterNamespaceWrapper where T: UICollectionView {
    
    /// 提前注册cell
    public func registerCell<CellType: UICollectionViewCell>(_ type: CellType.Type) {
        let identifier = self.getClassName(type.classForCoder())
        wrappedValue.register(type.self, forCellWithReuseIdentifier: identifier)
    }
    
    /// 提前注册SectionHeader
    public func registerSectionHeader<HeaderType: UICollectionReusableView>(_ type: HeaderType.Type) {
        let identifier = self.getClassName(type.classForCoder())
        wrappedValue.register(type.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: identifier)
    }
    
    /// 提前注册SectionFooter
    public func registerSectionFooter<FooterType: UICollectionReusableView>(_ type: FooterType.Type) {
        let identifier = self.getClassName(type.classForCoder())
        wrappedValue.register(type.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: identifier)
    }
    
    /// 获取复用的cell
    public func makeCell<CellType: UICollectionViewCell>(indexPath: IndexPath) -> CellType {
        let identifier = self.getClassName(CellType.classForCoder())
        guard let cell = wrappedValue.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? CellType else {
            return CellType()
        }
        return cell
    }
    
    /// 获取复用的 SectionHeader
    public func makeSectionHeader<HeaderType: UICollectionReusableView>(indexPath: IndexPath) -> HeaderType {
        let identifier = getClassName(HeaderType.classForCoder())
        guard let header = wrappedValue.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: identifier, for: indexPath) as? HeaderType else {
            return HeaderType()
        }
        return header
    }
    
    /// 获取复用的 SectionFooter
    public func makeSectionFooter<FooterType: UICollectionReusableView>(indexPath: IndexPath) -> FooterType {
        let identifier = getClassName(FooterType.classForCoder())
        guard let footer = wrappedValue.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: identifier, for: indexPath) as? FooterType else {
            return FooterType()
        }
        return footer
    }
}


extension BetterNamespaceWrapper where T: UICollectionView {
    
    fileprivate func getClassName(_ obj:Any) -> String {
        let mirro = Mirror(reflecting: obj)
        if let className = String(describing: mirro.subjectType).components(separatedBy: ".").first {
            return className
        }
        
        return ""
    }
}

