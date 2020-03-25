//
//  UpdateList.swift
//  BuildAnAppWithSwiftUI
//
//  Created by Howard Ge on 2020/3/25.
//  Copyright © 2020 Howard. All rights reserved.
//

import SwiftUI

struct UpdateList: View {
    var body: some View {
        NavigationView {                                                    // 导航视图
            List(updateData) { update in                                    // 更新信息列表，数据来自 updateData
                NavigationLink(destination: UpdateDetail(update: update)) {            // 导航项目，目标为更新信息的详情
                    HStack {
                        Image(update.image)                                 // 使用数据中的属性
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80, height: 80)
                            .background(Color.black)
                            .cornerRadius(20)
                            .padding(.trailing, 4)
                        VStack(alignment: .leading, spacing: 8) {
                            Text(update.title)
                                .font(.system(size: 20, weight: .bold))
                            Text(update.text)
                                .lineLimit(2)
                                .font(.subheadline)
                                .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                            Text(update.date)
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(.vertical, 8)
                }
            }
        .navigationBarTitle(Text("课程更新信息"))                                     // 导航视图的标题
        }
    }
}

struct UpdateList_Previews: PreviewProvider {
    static var previews: some View {
        UpdateList()
    }
}

struct Update: Identifiable {
    var id = UUID()
    var image: String
    var title: String
    var text: String
    var date: String
}

let updateData = [
    Update(image: "Card1", title: "SwiftUI 进阶", text: "使用 API 数据、包和 CMS 等高阶技术将 SwiftUI app 发布到 App Store", date: "10月17日"),
    Update(image: "Card2", title: "Webflow", text: "使用高级互动、支付和 CMS 设计高度转换加载页面和制作动画", date: "12月31日"),
    Update(image: "Card3", title: "ProtoPie", text: "为移动端和网络端制作带有高级动画和交互的原型", date: "8月21日"),
    Update(image: "Card4", title: "SwiftUI", text: "使用 Xcode 11 对自定义UI、动画、手势和组件进行编程", date: "3月9日"),
    Update(image: "Card5", title: "Framer Playground", text: "使用 Framer X 代码编辑器创建强大的动画和交互", date: "11月11日"),
    Update(image: "Card6", title: "测试一个内容比较长的", text: "红军不怕远征难，万水千山只等闲。五岭逶迤腾细浪，乌蒙磅礴走泥丸。金沙水拍云崖暖，大渡桥横铁索寒。更喜岷山千里雪，三军过后尽开颜。", date: "10月1日")
]


