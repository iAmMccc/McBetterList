//
//  ViewController.swift
//  MCBetterList
//
//  Created by iAmMccc on 09/03/2025.
//  Copyright (c) 2025 iAmMccc. All rights reserved.
//

import UIKit
import MCBetterList

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.frame = view.bounds
        
        // 1️⃣ 修改全局默认
//        ListPlaceholderDefaults.buttonConfigure = { btn in
//            btn.backgroundColor = .yellow
//            btn.layer.cornerRadius = 10
//            btn.setTitleColor(.white, for: .normal)
//        }

        // 2️⃣ 使用 ListPlaceholder
        let placeholder = ListPlaceholder()
//            .config {
//                $0.backgroundColor = .white
//                $0.padding = .init(top: 20, left: 20, bottom: 20, right: 20)
//                $0.alignment = .center
//            }
            .items {
                $0.spacer(50)
                $0.image(UIImage(named: "emptyImage_A"), size: CGSize(width: 380, height: 200))
//                $0.spacer(30)
                $0.title("暂无数据")
//                $0.spacer(12)
                $0.subTitle("请稍后再试请稍后再试请稍后再试请稍后再试请稍后再试请稍后再试请稍后再试")
//                $0.spacer(12)
                $0.button("自定义按钮") 
//                $0.spacer(12)
                $0.button("默认按钮") // 使用全局绿色按钮
            }

        tableView.backgroundView = placeholder
        
        tableView.mc.reloadData()
    }

    lazy var tableView = UITableView.mc.make(registerCells: [UITableViewCell.self], delegate: self)
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.mc.makeCell(indexPath: indexPath)
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
}

