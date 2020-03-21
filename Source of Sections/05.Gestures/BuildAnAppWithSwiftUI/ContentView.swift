//
//  ContentView.swift
//  BuildAnAppWithSwiftUI
//
//  Created by Howard Ge on 2020/3/17.
//  Copyright © 2020 Howard. All rights reserved.
//

import SwiftUI
/**
 Section 05 : Gestures and Events - 手势与事件
 */

struct ContentView: View {
    @State private var show = false     // 声明一个状态，简单的布尔值可以控制两个状态
    @State var viewState = CGSize.zero  // 声明一个状态，使用 CGSize 类型，并将其 width 和 height 都初始化为 0
    var body: some View {
        ZStack {                    // 注意栈中各个组件的顺序和实际显示的层级关系
            TitleView()             // 标题视图
                .blur(radius: show ? 10 : 0)                                    //根据 show 的值确定模糊度
                .animation(.default)
            BackCardView()          // 最下面一层
                .background(show ? Color("card3") : Color("card4"))             //根据 show 的值确定背景色
                .cornerRadius(20)
                .shadow(radius: 20)
                .offset(x: self.viewState.width, y: self.viewState.height)      //根据 show 的值确定偏移量
                .scaleEffect(0.9)
                .rotationEffect(.degrees(show ? 0 : 10))                        //根据 show 的值确定旋转角度
                .rotation3DEffect(.degrees(10), axis: (x: 10, y: 0, z: 0))      // 三维旋转
                .blendMode(.hardLight)
                .animation(.easeInOut(duration: 0.5))                           // 定义动画的类型和持续时间
            BackCardView()          // 中间一层
                .background(show ? Color("card4") : Color("card3"))
                .cornerRadius(20)
                .shadow(radius: 20)
                .offset(x: self.viewState.width, y: self.viewState.height)      //根据 show 的值确定偏移量
                .scaleEffect(0.95)
                .rotationEffect(Angle.degrees(show ? 0 : 5))                    // 根据 show 的状态确定旋转角度
                .rotation3DEffect(.degrees(5), axis: (x: 10, y: 0, z: 0))
                .blendMode(.hardLight)
                .animation(.easeInOut(duration: 0.3))   // 这个持续时间与前面不同，可以形成错落的效果
            CardView()              // 最上面一层
                // 将改变的 viewState 应用在组件的偏移量
                .offset(x: self.viewState.width, y: self.viewState.height)
                .blendMode(.hardLight)
                .animation(.spring(response: 0.3, dampingFraction: 0.5, blendDuration: 0))    // 使复位的动作更连贯
                .onTapGesture {                         // 定义响应的动作
                    self.show.toggle()                  // 切换 show 的状态
            }
            .gesture(
                DragGesture().onChanged { value in      // 拖拽事件的尾随闭包
                    self.viewState = value.translation  // 将拖拽事件的返回值传递给 viewState
                    self.show = true                    // 控制另一个状态，让其他的卡片在移动时展开
                }
                    .onEnded { value in                 // 拖拽结束，松开鼠标左键，另一个尾随闭包
                        self.viewState = .zero          // 复位卡片位置
                        self.show = false               // 复位所有的卡片
                }
            )
            BottomCardView()
                .blur(radius: show ? 20 : 0)
                .animation(.default)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CardView: View {
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("UI 设计")                  // 文本框，相当于 label
                        .font(.title)               // 字体
                        .fontWeight(.semibold)      // 字体粗细
                        .foregroundColor(.white)    // 前景色
                    Text("证书")
                        .foregroundColor(Color("accent"))
                }
                Spacer()
                Image("Logo1")                      // 图片
            }
                .padding(.horizontal, 20)           // 水平内边距
                .padding(.top, 20)                  // 顶部内边距
            Spacer()
            Image("Card1")
                .resizable()                        // 图片可改变大小，由此开始下面的各种调整
                .aspectRatio(contentMode: .fill)    // 纵横比
                .frame(width: 300, height: 110, alignment: .top)    // 定义尺寸和对齐
        }
        .frame(width: 340.0, height: 220.0)
        .background(Color.black)
        .cornerRadius(20)
        .shadow(radius: 20)
    }
}

struct BackCardView: View {
    var body: some View {
        VStack {
            Spacer()    //栈的占位符
        }
            .frame(width: 340.0, height: 220.0)     // 框体尺寸
    }
}

struct TitleView: View {
    var body: some View {
        VStack {
            HStack {
                Text("证书册")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
            }
            .padding()
            Image("Background1")
            Spacer()
        }
    }
}

struct BottomCardView: View {
    var body: some View {
        VStack(spacing: 20) {
            Rectangle()                             // 视图上方的条状按钮
                .frame(width: 40, height: 6)
                .cornerRadius(3)
                .opacity(0.1)                       // 透明度
            Text("Howard Ge 已经通过本机构《UI设计》课程学习并通过考核，特此证明。")
                .multilineTextAlignment(.center)    // 多行文本对齐
                .font(.subheadline)
                .lineSpacing(4)
            Spacer()
        }
        .padding(.top, 8)
        .padding(.horizontal, 20)
            .frame(maxWidth: .infinity)             // 撑满
            .background(Color.white)
            .cornerRadius(30)
            .shadow(radius: 20)
            .offset(x: 0, y: 500)
    }
}
