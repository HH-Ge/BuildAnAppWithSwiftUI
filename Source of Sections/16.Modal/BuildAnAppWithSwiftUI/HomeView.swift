//
//  HomeView.swift
//  BuildAnAppWithSwiftUI
//
//  Created by Howard Ge on 2020/3/24.
//  Copyright © 2020 Howard. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @Binding var showProfile: Bool
    @State var showUpdate = false
    
    var body: some View {
        VStack {                            // 主屏幕
            HStack {
                Text("浏览课程")
                    .font(.system(size: 28, weight: .bold))

                Spacer()
                
                AvatarView(showProfile: $showProfile)   // 状态变量绑定到子视图的参数
                
                Button(action: {self.showUpdate.toggle()}) {
                    Image(systemName: "bell")
                        .renderingMode(.original)
                        .font(.system(size: 16, weight: .medium))
                        .frame(width: 36, height: 36)
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)     // 小半径的边缘投影，突出边界
                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)   // 大半径的范围投影，悬浮效果
                    
                }
                .sheet(isPresented: $showUpdate) {
                    ContentView()
                }
            }
            .padding(.horizontal)
            .padding(.leading, 14)
            .padding(.top)
            
            // 如果是垂直滚动，要把 horizontal 改成 vertical，HStack 改成 VStack
            ScrollView(.horizontal, showsIndicators: false) {   // 水平滚动，不显示滚动条
                HStack(spacing: 20) {                           // 水平放置
                    ForEach(sectionData) { item in              // 遍历数组
                        GeometryReader { geometry in            // 获取卡片的位置
                            SectionView(section: item)          // 子视图
                            .rotation3DEffect(Angle(degrees:
                               Double(geometry.frame(in: .global).minX - 30) / -20
                            ), axis: (x: 0, y: 10, z: 0))
                        }
                    .frame(width: 275, height: 275)             // 让卡片分开
                    }
                }
                .padding(30)
                .padding(.bottom, 30)
            }
            
            Spacer()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(showProfile: .constant(false))
    }
}

struct SectionView: View {
    var section: Section        // 声明类型为 Section 的变量用来传递数据
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Text(section.title)         // 使用变量替代原先的静态值
                    .font(.system(size: 24, weight: .bold))
                    .frame(width: 160, alignment: .leading)
                    .foregroundColor(.white)
                
                Spacer()
                
                Image(section.logoName)     // 使用变量替代原先的静态值
            }
            
            Text(section.text)              // 使用变量替代原先的静态值
                .frame(maxWidth: .infinity, alignment: .leading)
            
            section.image                   // 使用变量替代原先的静态值
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 210)
        }
        .padding(.top, 20)
        .padding(.horizontal, 20)
        .frame(width: 275, height: 275)
        .background(section.color)          // 使用变量替代原先的静态值
        .cornerRadius(30)
        .shadow(color: section.color.opacity(0.3), radius: 20, x: 0, y: 20)     // 使用变量替代原先的静态值
    }
}

struct Section: Identifiable {
    var id = UUID()             // 编号，唯一的
    var title: String           // 标题
    var text: String            // 课时
    var logoName: String        // Logo名
    var image: Image            // 图片
    var color: Color            // 颜色
}

let sectionData = [
    Section(title: "SwiftUI \n原型设计", text: "共 18 讲", logoName: "Logo1", image: Image("Card1"), color: Color("card1")),
    Section(title: "SwiftUI \nApp开发", text: "共 20 讲", logoName: "Logo2", image: Image(uiImage:#imageLiteral(resourceName: "wowLM")), color: Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1))),
    Section(title: "SwiftUI \nMac开发", text: "共 15 讲", logoName: "Logo3", image: Image("Card3"), color: Color("card3"))
]




