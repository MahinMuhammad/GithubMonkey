//
//  ContentView.swift
//  GithubMonkey
//
//  Created by Md. Mahinur Rahman on 10/29/23.
//

/*
 Copyright 2023 Md. Mahinur Rahman
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = FolllowViewModel()
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text(viewModel.getSubHedding())
                    .font(.system(size: 16))
                    .foregroundStyle(.gray)
                    .padding(.top,-15)
                
                List(viewModel.getUsersToPopulateList()){user in
                    HStack(alignment: .top){
                        AsyncImage(url: URL(string: user.avatar_url)) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 40, height: 40)
                                .clipped()
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                        } placeholder: {
                            Image(systemName: "person.crop.circle")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 40, height: 40)
                                .clipped()
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                        }
                        
                        Text(user.username)
                            .font(.system(size: 18.5))
                    }
                    .listRowSeparator(.hidden)
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
