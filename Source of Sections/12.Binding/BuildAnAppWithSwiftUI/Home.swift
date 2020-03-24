//
//  Home.swift
//  BuildAnAppWithSwiftUI
//
//  Created by Howard Ge on 2020/3/22.
//  Copyright © 2020 Howard. All rights reserved.
//

import SwiftUI

/**
 12. Binding - 状态绑定
 */
struct Home: View {
    @State var showProfile = false              // 声明控制动画的状态变量
    @State var viewState = CGSize.zero          // 视图位置的状态，用来协助 MenuView 的拖动
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))                           // ZStack 最前面，即最底层
                .edgesIgnoringSafeArea(.all)    // 忽略安全区域，满屏
            
            HomeView(showProfile: $showProfile)
                .padding(.top, 44)                      // 让出安全区域（这是 iPhone 11 Pro 的数据）
                .background(Color.white)                // 主屏幕的背景颜色
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
                .offset(y: showProfile && viewState.height >= 0 ? viewState.height - 450 : viewState.height)
                .rotation3DEffect(
                    Angle(degrees: (showProfile && (viewState.height < 0) && (viewState.height > -500)) ? Double(viewState.height) / 5 - 10 : 0), axis: (x: 10000, y: 0, z: 0), anchor: .top)
                .scaleEffect(showProfile ? 0.9 : 1)     // 使用 showProfile 控制缩放效果
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                .edgesIgnoringSafeArea(.all)            // 忽略安全区域，填满屏幕
            
            MenuView()
                .background(Color.black.opacity(0.001)) // 透明度是为了不显示但是能点击交互
                .offset(y: showProfile ? 0 : screen.height)      // showProfile 为 false 时隐藏，偏移整个屏幕高度，确保在屏幕之外
                .offset(y: viewState.height)            // 跟随拖动改变偏移
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                .onTapGesture {
                    self.showProfile.toggle()           // 关闭视图
            }
            .gesture(
                DragGesture().onChanged { value in
                    self.viewState = value.translation
                }
                .onEnded { value in
                    if self.viewState.height > 50 {     // 向下拖动超过 50 时，关闭组件
                        self.showProfile = false
                    }
                    self.viewState = .zero
                }
            )
        }
        
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}




struct AvatarView: View {
    @Binding var showProfile: Bool                      // 使用绑定来同步传递、修改状态
    var body: some View {
        Button(action: {self.showProfile.toggle()}) {   // 按钮单击响应，切换 showProfile 状态
            Image("wowLM_small")
                .renderingMode(.original)               // 修改渲染模式，保证图片正常显示
                .resizable()
                .frame(width: 36, height: 36)
                .clipShape(Circle())
        }
    }
}


let screen = UIScreen.main.bounds
