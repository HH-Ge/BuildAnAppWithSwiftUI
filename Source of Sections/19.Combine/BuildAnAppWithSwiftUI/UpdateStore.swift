//
//  UpdateStore.swift
//  BuildAnAppWithSwiftUI
//
//  Created by Howard Ge on 2020/3/25.
//  Copyright © 2020 Howard. All rights reserved.
//

import SwiftUI
import Combine                                          // 导入 Combine

class UpdateStore: ObservableObject {                   // 定义用于存储更新信息的类
    @Published var updates: [Update] = updateData       // 声明publisher，类型为 Update 数组，默认值为 updateData
}
