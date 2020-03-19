//
//  ContentView.swift
//  BuildAnAppWithSwiftUI
//
//  Created by Howard Ge on 2020/3/17.
//  Copyright © 2020 Howard. All rights reserved.
//

import SwiftUI
/**
 Section 2 : Layout & Stacks - 布局和堆栈
 */

struct ContentView: View {
    var body: some View {
        ZStack {            // 注意栈中各个组件的顺序和实际显示的层级关系
            VStack {        // 最下面一层
                Spacer()    //栈的占位符
            }
            .frame(width: 300.0, height: 220.0)     // 框体尺寸
            .background(Color.blue)     // 背景
            .cornerRadius(20)           // 圆角，因为有切图效果，所以要放在阴影之前
            .shadow(radius: 20)         // 阴影
            .offset(x: 0, y: -20)       // 偏移
            VStack {        // 最上面一层
                HStack {
                    VStack(alignment: .leading) {
                        Text("UI 设计")               // 文本框，相当于 label
                            .font(.title)               // 字体
                            .fontWeight(.semibold)      // 字体粗细
                            .foregroundColor(.white)    // 前景色
                        Text("证书")
                            .foregroundColor(Color("accent"))
                    }
                    Spacer()
                    Image("Logo1")      // 图片
                }
                .padding(.horizontal, 20)       // 水平内边距
                .padding(.top, 20)              // 顶部内边距
                Spacer()
                Image("Card1")
                    .resizable()                // 图片可改变大小，由此开始下面的各种调整
                    .aspectRatio(contentMode: .fill)        // 纵横比
                    .frame(width: 300, height: 110, alignment: .top)
            }
            .frame(width: 340.0, height: 220.0)
            .background(Color.black)
            .cornerRadius(20)
            .shadow(radius: 20)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
