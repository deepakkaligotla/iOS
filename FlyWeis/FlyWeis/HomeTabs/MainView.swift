//
//  HomeView.swift
//  FlyWeis
//
//  Created by Deepak Kaligotla on 08/08/24.
//

import SwiftUI

struct MainView: View {
    private var pageTitles = ["Home", "Logbook", "Messages", "More"]
    @State private var selectedTab: Int = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Label(pageTitles[0], systemImage: "house")
                }
                .tag(0)
            
            LogbookView()
                .tabItem {
                    Label(pageTitles[1], systemImage: "book.closed")
                }
                .tag(1)
            
            MessagesView()
                .tabItem {
                    Label(pageTitles[2], systemImage: "message.badge")
                }
                .tag(2)
            
            MoreView()
                .tabItem {
                    Label(pageTitles[3], systemImage: "ellipsis.rectangle")
                }
                .tag(3)
        }
        .accentColor(Color(red: 52/255, green: 183/255, blue: 193/255))
    }
}

#Preview {
    MainView()
}
