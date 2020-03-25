//
//  UpdateDetail.swift
//  BuildAnAppWithSwiftUI
//
//  Created by Howard Ge on 2020/3/25.
//  Copyright © 2020 Howard. All rights reserved.
//

import SwiftUI

struct UpdateDetail: View {
    var update: Update =  updateData[0]                                 // 设定用于传值的变量，并给默认值
    
    var body: some View {
        List {
            VStack(spacing: 20) {
                Image(update.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)                         // 撑满，保持图片显示统一
                Text(update.text)
                    .frame(maxWidth: .infinity, alignment: .leading)    // 撑满，左对齐，保持内容显示统一
            }
            .navigationBarTitle(update.title)       // 指明导航标题，这个在这里预览不出来，需要 Navigation
        }
    .listStyle(PlainListStyle())                    // 指明 List 的样式，另一个常用的是 GroupedListStyle
    }
}

struct UpdateDetail_Previews: PreviewProvider {
    static var previews: some View {
        UpdateDetail()
    }
}
