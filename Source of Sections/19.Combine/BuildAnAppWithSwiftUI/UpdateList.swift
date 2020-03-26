//
//  UpdateList.swift
//  BuildAnAppWithSwiftUI
//
//  Created by Howard Ge on 2020/3/25.
//  Copyright © 2020 Howard. All rights reserved.
//

import SwiftUI

struct UpdateList: View {
    @ObservedObject var store = UpdateStore()                               // 声明 UpdateStore 类对象
    
    // 增加一条新的更新信息
    func addUpdate() {
        store.updates.append(Update(image: "WXAvatar", title: "新增课程", text: "课程详细信息", date: "1月1日"))
    }
    
    
    var body: some View {
        NavigationView {                                // 导航视图
            List {
                ForEach(store.updates) { update in      // 使用 store 中的 updates 为数据
                    NavigationLink(destination: UpdateDetail(update: update)) { // 导航项目，目标为更新信息的详情
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
                .onDelete { index in
                    self.store.updates.remove(at: index.first!)
                }
                .onMove { (source: IndexSet, destination: Int) in
                    self.store.updates.move(fromOffsets: source, toOffset: destination)
                }
            }
                .navigationBarTitle(Text("课程更新信息"))                     // 导航视图的标题
                .navigationBarItems(leading: Button(action: addUpdate){     // 在导航标题上方增加按钮，单击后执行 addUpdate 函数
                    Text("新增")
                }, trailing: EditButton())
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


