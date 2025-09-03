//
//  UITableView+Extension.swift
//  
//
//  Created by Mccc on 2020/6/11.
//


import UIKit




extension UITableView: BetterNamespaceWrappable { }



// MARK: - UITableView 初始化扩展
extension BetterNamespaceWrapper where T: UITableView {
    
    /// UITableView 初始化方法
    /// - Parameters:
    ///   - cells: 要注册的 Cell，数组类型，例如：[UITableViewCell.self]
    ///   - headers: 要注册的 sectionHeaders，数组类型，例如：[UITableViewHeaderFooterView.self]
    ///   - footers: 要注册的 sectionFooters，数组类型，例如：[UITableViewHeaderFooterView.self]
    ///   - delegate: UITableViewDelegate & UITableViewDataSource
    ///   - style: UITableView.Style，默认为 plain
    public static func make<TableType: UITableView,
                            CellType: UITableViewCell,
                            HeaderType: UITableViewHeaderFooterView,
                            FooterType: UITableViewHeaderFooterView>(
        registerCells cells: [CellType.Type],
        registerHeaders headers: [HeaderType.Type]? = nil,
        registerFooters footers: [FooterType.Type]? = nil,
        delegate: UITableViewDelegate & UITableViewDataSource,
        style: UITableView.Style = .plain
    ) -> TableType {
        
        let tb = TableType(frame: .zero, style: style)
        tb.delegate = delegate
        tb.dataSource = delegate
        tb.separatorStyle = .none
        
        // 关闭预估高度，防止长图显示异常
        tb.estimatedRowHeight = 0
        tb.estimatedSectionHeaderHeight = 0
        tb.estimatedSectionFooterHeight = 0
        
        // 注册 Cell
        for item in cells { tb.mc.registerCell(item) }
        
        // 注册 Header
        if let temp = headers {
            for item in temp { tb.mc.registerSectionHeader(item) }
        }
        
        // 注册 Footer
        if let temp = footers {
            for item in temp { tb.mc.registerSectionFooter(item) }
        }
        
        return tb
    }
}

// MARK: - UITableView 注册扩展
extension BetterNamespaceWrapper where T: UITableView {
    
    /// 注册 Cell
    public func registerCell<CellType: UITableViewCell>(_ type: CellType.Type) {
        let identifier = self.getClassName(type.classForCoder())
        wrappedValue.register(type.self, forCellReuseIdentifier: identifier)
    }
    
    /// 注册 SectionHeader
    public func registerSectionHeader<HeaderType: UITableViewHeaderFooterView>(_ type: HeaderType.Type) {
        let identifier = self.getClassName(type.classForCoder())
        wrappedValue.register(type.self, forHeaderFooterViewReuseIdentifier: identifier)
    }
    
    /// 注册 SectionFooter
    public func registerSectionFooter<FooterType: UITableViewHeaderFooterView>(_ type: FooterType.Type) {
        let identifier = self.getClassName(type.classForCoder())
        wrappedValue.register(type.self, forHeaderFooterViewReuseIdentifier: identifier)
    }
}

// MARK: - UITableView 获取复用 Cell/Header/Footer 扩展
extension BetterNamespaceWrapper where T: UITableView {
    
    /// 获取复用 Cell
    public func makeCell<CellType: UITableViewCell>(indexPath: IndexPath) -> CellType {
        let identifier = self.getClassName(CellType.classForCoder())
        guard let cell = wrappedValue.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? CellType else {
            return CellType()
        }
        cell.selectionStyle = .none
        return cell
    }
    
    /// 获取复用 SectionHeader
    public func makeSectionHeader<HeaderType: UITableViewHeaderFooterView>(_: HeaderType.Type) -> HeaderType {
        let identifier = getClassName(HeaderType.classForCoder())
        guard let header = wrappedValue.dequeueReusableHeaderFooterView(withIdentifier: identifier) as? HeaderType else {
            return HeaderType()
        }
        return header
    }
    
    /// 获取复用 SectionFooter
    public func makeSectionFooter<FooterType: UITableViewHeaderFooterView>(_: FooterType.Type) -> FooterType {
        let identifier = getClassName(FooterType.classForCoder())
        guard let footer = wrappedValue.dequeueReusableHeaderFooterView(withIdentifier: identifier) as? FooterType else {
            return FooterType()
        }
        return footer
    }
}

// MARK: - 辅助方法
extension BetterNamespaceWrapper where T: UITableView {
    
    /// 获取类名
    fileprivate func getClassName(_ obj: Any) -> String {
        let mirror = Mirror(reflecting: obj)
        let className = String(describing: mirror.subjectType).components(separatedBy: ".").first ?? ""
        return className
    }
}
