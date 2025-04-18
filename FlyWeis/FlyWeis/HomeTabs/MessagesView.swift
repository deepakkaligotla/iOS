//
//  MessagesView.swift
//  FlyWeis
//
//  Created by Deepak Kaligotla on 09/08/24.
//

import SwiftUI

struct MessagesView: View {
    @State private var searchName = ""
    @State private var users: [UserResponse.User] = []
    @State private var isLoading = false
    @State private var error: String?
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
                VStack {
                    if isLoading {
                        ProgressView("Loading...")
                            .progressViewStyle(CircularProgressViewStyle())
                    } else {
                        List {
                            ForEach(searchResults, id: \.email) { user in
                                NavigationLink(destination: DetailView(name: user.fullName)) {
                                    HStack {
                                        Image("logo")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 50, height: 50)
                                            .background(Color.random())
                                            .clipShape(Circle())
                                        
                                        Spacer().frame(width: 10)
                                        
                                        VStack(alignment: .leading) {
                                            HStack {
                                                Text(user.firstName).font(.title3)
                                                Spacer()
                                                Text("new Message").font(.caption)
                                                Text("1")
                                                    .font(.body)
                                                    .frame(width: 16, height: 16, alignment: .center)
                                                    .background(Color(red: 255/255, green: 146/255, blue: 89/255))
                                                    .clipShape(Circle())
                                                    .foregroundColor(.white)
                                            }
                                            HStack {
                                                Text("""
                                                Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
                                                """)
                                                .font(.caption).lineLimit(2, reservesSpace: true)
                                                .multilineTextAlignment(.leading)
                                                Spacer()
                                                Text(currentTime)
                                                    .font(.caption)
                                                    .foregroundColor(.gray)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        .searchable(text: $searchName)
                        .navigationTitle("Messages")
                        .navigationBarTitleDisplayMode(.inline)
                    }
                }
                .onAppear {
                    fetchUsers()
                }
                
                NavigationLink(destination: NewChatView(users: users)) {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(Color(red: 52/255, green: 183/255, blue: 193/255))
                        .padding()
                }
                .padding()
            }
        }
    }
    
    var searchResults: [UserResponse.User] {
        if searchName.isEmpty {
            return users
        } else {
            return users.filter { $0.fullName.localizedCaseInsensitiveContains(searchName) }
        }
    }
    
    private var currentTime: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm:ss a"
        return formatter.string(from: Date())
    }
    
    private func fetchUsers() {
        isLoading = true
        API.fetchUsers(search: "", dutyStatus: "", fromDate: "", toDate: "", page: 1, limit: 20) { result in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success(let response):
                    users = response.users
                case .failure(let apiError):
                    error = apiError.localizedDescription
                }
            }
        }
    }
}

struct DetailView: View {
    let name: String
    
    var body: some View {
        Text("Chat with \(name)")
            .font(.largeTitle)
            .navigationTitle(name)
    }
}

#Preview {
    MessagesView()
}
