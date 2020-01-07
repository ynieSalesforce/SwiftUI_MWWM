//
//  BaseViewController.swift
//  SwiftUIDemo
//
//  Created by Yuchen Nie on 1/3/20.
//  Copyright © 2020 Yuchen Nie. All rights reserved.
//

import Foundation
import ReactiveSwift

class BaseViewController: UIViewController {
    let lifeCycle = ViewLifeCycle()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lifeCycle.viewWillAppear()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lifeCycle.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        lifeCycle.viewDidAppear()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        lifeCycle.viewDidDisappear()
    }
}
