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
                Text("Howard Ge - 完成度 52%")
                    .font(.caption)
                Color.white
                    .frame(width: 38, height: 6)                            // 进度标志
                    .cornerRadius(3)                                        // 圆角修饰
                    .frame(width: 130, height: 6, alignment: .leading)      // 放入新的框架
                    .background(Color.black.opacity(0.08))
                    .cornerRadius(3)
                    .padding()
                    .frame(width: 150, height: 24)                          // 再放入新的框架
                    .background(Color.black.opacity(0.1))
                    .cornerRadius(12)
//                Image("wowLM_small")                     // 头像图片
//                    .resizable()                      // 可变大小
//                    .frame(width: 80, height: 80)     // 定义大小
//                    .offset(y: -60)                   // 偏移
                MenuRow(title: "账  号", iconName: "gear")
                MenuRow(title: "账  单", iconName: "creditcard")
                MenuRow(title: "退  出", iconName: "person.circle")
                
            }
            .frame(maxWidth: .infinity)
            .frame(height: 300)
            .background(                                                               // 线性渐变
                LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)), Color(#colorLiteral(red: 0.8705882353, green: 0.8941176471, blue: 0.9450980392, alpha: 1))]),     // 基础渐变，起始颜色和结束颜色
                               startPoint: .top,                                       // 起始位置
                               endPoint: .bottom))                                     // 结束位置
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .overlay(
                Image("wowLM_small")                    // 头像图片
                    .resizable()                        // 可变大小
                    .aspectRatio(contentMode: .fill)    // 填充宽高比例
                    .frame(width: 80, height: 80)       // 定义大小
                    .clipShape(Circle())                // 裁剪
                    .offset(y: -150)                    // 偏移
            )
                .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)       // 调整了shadow
                .padding(.horizontal, 30)
            
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
                .foregroundColor(Color(#colorLiteral(red: 0.662745098, green: 0.7333333333, blue: 0.831372549, alpha: 1)))                     // 使用 Color Literal 选择颜色
            Text(title)
                .font(.system(size: 20, weight: .bold, design: .default))
                .frame(width: 120, alignment: .leading)
        }
    }
}
