//
//  MyTheme.swift
//  TodayNews
//
//  Created by 杨蒙 on 2017/8/17.
//  Copyright © 2017年 hrscy. All rights reserved.
//

import Foundation
import SwiftTheme

enum MyTheme: Int {

    case day = 0
    case night = 1
    
    /// 选择主题
    static func switchTo(_ theme: MyTheme) {
        switch theme {
            case .day: ThemeManager.setTheme(plistName: "default_theme", path: .mainBundle)
            case .night: ThemeManager.setTheme(plistName: "night_theme", path: .mainBundle)
        }
    }
    
    /// 选择了黑色主题
    static func switchNight(_ isToNight: Bool) {
        switchTo(isToNight ? .night : .day)
    }
}
