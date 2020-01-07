//
//  ViewLifeCycle.swift
//  SwiftUIDemo
//
//  Created by Yuchen Nie on 1/3/20.
//  Copyright © 2020 Yuchen Nie. All rights reserved.
//

import Foundation
import ReactiveSwift

struct ViewLifeCycle {
    
    let viewWillAppearProperty = MutableProperty(())
    public func viewWillAppear() {
      viewWillAppearProperty.value = ()
    }
    
    let viewDidLoadProperty = MutableProperty(())
    public func viewDidLoad() {
      viewDidLoadProperty.value = ()
    }

    let viewDidAppearProperty = MutableProperty(())
    public func viewDidAppear() {
      viewDidAppearProperty.value = ()
    }

    let viewDidDisappearProperty = MutableProperty(())
    public func viewDidDisappear() {
      viewDidDisappearProperty.value = ()
    }
}
