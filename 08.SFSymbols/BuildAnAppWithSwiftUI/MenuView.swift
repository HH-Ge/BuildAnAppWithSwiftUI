//
//  MenuView.swift
//  BuildAnAppWithSwiftUI
//
//  Created by Howard Ge on 2020/3/21.
//  Copyright © 2020 Howard. All rights reserved.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        VStack {
            Spacer()        // 占位
            
            VStack(spacing: 16) {
                MenuRow(title: "账  号", iconName: "gear")
                MenuRow(title: "账  单", iconName: "creditcard")
                MenuRow(title: "退  出", iconName: "person.circle")
            }
            .frame(maxWidth: .infinity)
            .frame(height: 300)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(radius: 30)
            .padding()
        }
        .padding(.bottom, 30)   // 底部留空
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}

struct MenuRow: View {
    var title: String       // 定义标题属性，如果定义了默认值，则调用的时候可以省略
    var iconName: String    // 定义图标属性
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: iconName)   // gear 就是 SF 符号的名称
                .font(.system(size: 20, weight: .light))        // 字体修饰
                .imageScale(.large)                             // 图片缩放
                .frame(width: 32, height: 32)
            Text(title)
                .font(.system(size: 20, weight: .bold, design: .default))
                .frame(width: 120, alignment: .leading)
        }
    }
}
