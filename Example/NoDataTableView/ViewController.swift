//
//  ViewController.swift
//  NoDataTableView
//
//  Created by guoqiang@laien.io on 06/23/2022.
//  Copyright (c) 2022 guoqiang@laien.io. All rights reserved.
//

import UIKit
import NoDataTableView

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let temp = NoDataTableView.init(frame: .init(x: 50, y: 100, width: 300, height: 300), type: .noDownload)
        view.addSubview(temp)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

