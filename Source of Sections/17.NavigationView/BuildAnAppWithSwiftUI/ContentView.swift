//
//  ContentView.swift
//  BuildAnAppWithSwiftUI
//
//  Created by Howard Ge on 2020/3/17.
//  Copyright © 2020 Howard. All rights reserved.
//

import SwiftUI
/**
 Section 06 : Timing Curve and Delay Animation - 时序曲线和延时动画
 */

struct ContentView: View {
    @State private var show = false         // 声明一个状态，简单的布尔值可以控制两个状态
    @State var viewState = CGSize.zero      // 声明一个状态，使用 CGSize 类型，并将其 width 和 height 都初始化为 0
    @State private var showCard = false     // 显示整个UI视图的状态
    @State var bottomState = CGSize.zero    // 记录 BottomCardView 的高度位置
    @State var showFull = false             // 是否显示整张 BottomCardView
    
    var body: some View {
        ZStack {                    // 注意栈中各个组件的顺序和实际显示的层级关系
            TitleView()                                 // 标题视图
                .blur(radius: show ? 10 : 0)            // 根据 show 的值确定模糊度
                .opacity(showCard ? 0.4 : 1)            // 根据 showCard 的值确定透明度
                .offset(y: showCard ? -200 : 0)         // 根据 showCard 的值确定偏移量
                .animation(
                    Animation
                        .default                                  // 动画形式
                        .delay(0.1)                               // 动画延迟
                        .speed(2)                                 // 动画速度
//                        .repeatCount(3)                         // 动画重复次数 为 3，往返共 3 次
//                        .repeatCount(3, autoreverses: false)    // 动画重复次数 为 3，往返 3 次
//                        .repeatForever(autoreverses: true)      // 呃~~根本停不下来？
            )
            
            BackCardView()          // 最下面一层，第三张卡
                .frame(width: showCard ? 300 : 340, height: 220.0)    // 使用 showCard 状态微调框体大小
                .background(show ? Color("card3") : Color("card4"))   // 根据 show 的值确定背景色
                .cornerRadius(20)
                .shadow(radius: 20)
                .offset(x: self.viewState.width, y: self.viewState.height - 20)  // 根据 show 的值确定偏移量
                .offset(y: showCard ? -180 : 0)                             // 使用 showCard 状态控制纵向偏移
                .scaleEffect(showCard ? 1 : 0.9)                            // 使用 showCard 状态控制缩放
                .rotationEffect(.degrees(show ? 0 : 10))                    // 根据 show 的值确定旋转角度
                .rotationEffect(.degrees(showCard ? -10 : 0))               // 使用 showCard 状态修正旋转
                .rotation3DEffect(.degrees(10), axis: (x: showCard ? 0 : 10, y: 0, z: 0))     // 使用 showCard 状态控制 三维旋转
                .blendMode(.hardLight)
                .animation(.easeInOut(duration: 0.3))           // 定义动画的类型和持续时间
            
            BackCardView()          // 中间一层，第二张卡
                .frame(width: 340.0, height: 220.0)     // 框体尺寸
                .background(show ? Color("card4") : Color("card3"))
                .cornerRadius(20)
                .shadow(radius: 20)
                .offset(x: self.viewState.width, y: self.viewState.height - 10)  // 根据 show 的值确定偏移量
                .offset(y: showCard ? -140 : 0)
                .scaleEffect(showCard ? 1 : 0.95)
                .rotationEffect(Angle.degrees(show ? 0 : 5))    // 根据 show 的状态确定旋转角度
                .rotationEffect(.degrees(showCard ? -5 : 0))
                .rotation3DEffect(.degrees(5), axis: (x: showCard ? 0 : 10, y: 0, z: 0))
                .blendMode(.hardLight)
                .animation(.easeInOut(duration: 0.3))   // 这个持续时间与前面不同，可以形成错落的效果
            
            CardView()              // 最上面一层
                .frame(width: showCard ? 375 : 340.0, height: 220.0)    // 使用 showCard 状态控制 CardView 的框体大小
                .background(Color.black)
                //.cornerRadius(20)
                .clipShape(RoundedRectangle(cornerRadius: showCard ? 30 : 20, style: .continuous))
                .shadow(radius: showCard ? 30 : 20)
                .offset(x: viewState.width, y: viewState.height)
                .offset(y: showCard ? -100 : 0)         // 使用 showCard 控制偏移
                .blendMode(.hardLight)
                .animation(.spring(response: 0.3, dampingFraction: 0.5, blendDuration: 0))    // 使复位的动作更连贯
                .onTapGesture {                         // 定义响应的动作
                    self.showCard.toggle()              // 从 show 修改为 showCard
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
            
            //Text("bottomState.height \n \(bottomState.height)").offset(y: -320)
            
            BottomCardView()
                .offset(x: 0, y: showCard ? 360 : 1000) // 默认不显示，单击切换 showCard 为 true 时显示
                .offset(y: bottomState.height)          // 使用相对偏移量控制卡片顶端位置
                .blur(radius: show ? 20 : 0)
                .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8))   // 时序曲线动画
                .gesture(
                    DragGesture()                       // 使用拖拽手势
                        .onChanged { value in           // 拖拽中
                            self.bottomState = value.translation
                            if self.showFull {
                                self.bottomState.height += -300
                            }
                            if self.bottomState.height < -300 {
                                self.bottomState.height = -300
                            }
                    }
                    .onEnded { value in                 // 拖拽停止时
                        if self.bottomState.height > 50 {
                            self.showCard = false
                        }
                        
                        if (self.bottomState.height < -100 && !self.showFull) || (self.bottomState.height < -250 && self.showFull) {
                            self.bottomState.height = -300
                            self.showFull = true
                        } else {
                            self.bottomState = .zero
                            self.showFull = false
                        }
                    }
            )
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
    }
}

struct BackCardView: View {
    var body: some View {
        VStack {
            Spacer()    //栈的占位符
        }
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
            Text("This certificate is proof that Howard Ge achieved the UI Design course with approval form a Design+Code instructor.")
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
            
    }
}
