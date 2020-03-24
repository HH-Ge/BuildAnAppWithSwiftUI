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
    
    var body: some View {
        VStack {                            // 主屏幕
            HStack {
                Text("浏览课程")
                    .font(.system(size: 28, weight: .bold))

                Spacer()
                
                AvatarView(showProfile: $showProfile)   // 状态变量绑定到子视图的参数
            }
            .padding(.horizontal)
            .padding(.leading, 14)
            .padding(.top)
            
            // 如果是垂直滚动，要把 horizontal 改成 vertical，HStack 改成 VStack
            ScrollView(.horizontal, showsIndicators: false) {   // 水平滚动，不显示滚动条
                HStack(spacing: 30) {                           // 水平放置
                    ForEach(0 ..< 5) { item in                  // 重复 5 次
                        SectionView()                           // 子视图
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
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Text("SwiftUI \n原型设计")
                    .font(.system(size: 24, weight: .bold))
                    .frame(width: 160, alignment: .leading)
                    .foregroundColor(.white)
                
                Spacer()
                
                Image("Logo1")
            }
            
            Text("共 18 讲")
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Image("Card1")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 210)
        }
        .padding(.top, 20)
        .padding(.horizontal, 20)
        .frame(width: 275, height: 275)
        .background(Color("card1"))
        .cornerRadius(30)
        .shadow(color: Color("card1").opacity(0.3), radius: 20, x: 0, y: 20)
    }
}
