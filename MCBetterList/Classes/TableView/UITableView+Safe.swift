//
//  UITableView+Extension.swift
//  
//
//  Created by Mccc on 2020/6/11.
// UITableView安全防越界

import UIKit


extension BetterNamespaceWrapper where T: UITableView {
    
    /// UITableView安全的滚动到指定IndexPath的方法
    /// - Parameters:
    ///   - indexPath: 要滚动到的目的地
    ///   - position: 目标视图滚动到的位置，默认为top，即上贴顶
    ///   - animation: 是否需要滚动动画
    public func safeScrollToRow(at indexPath: IndexPath, at position: T.ScrollPosition = .top, animation: Bool = true) {
        
        // indexPath非法检测
        guard indexPath.row >= 0 && indexPath.section >= 0 else { return }
        
        // tableView section数量防越界
        let sections = wrappedValue.numberOfSections
        guard sections > 0 && indexPath.section < sections else { return }
        
        // tableView row数量防越界
        let rows = wrappedValue.numberOfRows(inSection: indexPath.section)
        guard rows > 0 && indexPath.row < rows else { return }
        
        // 允许滚动
        wrappedValue.scrollToRow(at: indexPath, at: position, animated: animation)
    }
}



