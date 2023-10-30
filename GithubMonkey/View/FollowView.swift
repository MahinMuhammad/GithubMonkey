//
//  ContentView.swift
//  GithubMonkey
//
//  Created by Md. Mahinur Rahman on 10/29/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = FolllowViewModel()
    var body: some View {
        NavigationStack {
            VStack {
                List(viewModel.getUsersToPopulateList()){user in
                    Text(user.username)
                }
                .listStyle(.plain)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("\(viewModel.getTitle()) \(String(viewModel.getUsersToPopulateList().count))")
                        .font(.title3)
                }
                
                ToolbarItem {
                    Menu {
                        Button {
                            viewModel.selectedListType = .followers
                        }label: {
                            Label("Followers", systemImage: "figure.walk.arrival")
                        }
                        
                        Button{
                            viewModel.selectedListType = .following
                        } label: {
                            Label("Following", systemImage: "figure.walk.departure")
                        }
                        
                        Button{
                            viewModel.selectedListType = .nonfollowers
                        } label: {
                            Label("Doesn't Follow back", systemImage: "person.2.slash")
                        }
                    } label: {
                        Label("Option", systemImage: "ellipsis")
                            .foregroundStyle(Color(UIColor.label))
                    }
                }
            }
            .padding()
            .onAppear{
                            viewModel.loadList()
            }
        }
    }
}

#Preview {
    ContentView()
}
