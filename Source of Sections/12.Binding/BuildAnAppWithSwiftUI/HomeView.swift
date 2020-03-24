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
                Text("Watching")
                    .font(.system(size: 28, weight: .bold))
                
                Spacer()
                
                AvatarView(showProfile: $showProfile)   // 状态变量绑定到子视图的参数
            }
            .padding(.horizontal)
            .padding(.top)
            
            Spacer()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(showProfile: .constant(false))
    }
}
