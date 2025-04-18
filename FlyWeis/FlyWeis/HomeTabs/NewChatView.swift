//
//  NewChatView.swift
//  FlyWeis
//
//  Created by Deepak Kaligotla on 10/08/24.
//

import SwiftUI

struct NewChatView: View {
    @State private var searchName = ""
    let users: [UserResponse.User]
    
    private var sortedUsers: [String: [UserResponse.User]] {
        Dictionary(grouping: users, by: { String($0.fullName.prefix(1)).uppercased() })
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(searchResults.keys.sorted(), id: \.self) { key in
                    Section(header: Text(key)) {
                        ForEach(searchResults[key]!, id: \.email) { user in
                            HStack {
                                Image("logo") // Replace with user-specific image if available
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                    .background(Color.random())
                                    .clipShape(Circle())
                                
                                Text(user.fullName)
                                    .font(.headline)
                            }
                        }
                    }
                }
            }
            .searchable(text: $searchName)
            .listStyle(GroupedListStyle())
            .navigationTitle("New Chat")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    var searchResults: [String: [UserResponse.User]] {
        if searchName.isEmpty {
            return sortedUsers
        } else {
            let filtered = sortedUsers.mapValues { users in
                users.filter { $0.fullName.localizedCaseInsensitiveContains(searchName) }
            }
            return filtered.filter { !$0.value.isEmpty }
        }
    }
}

#Preview {
    NewChatView(users: [])
}
