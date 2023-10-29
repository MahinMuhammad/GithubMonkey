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
        VStack {
            Picker(selection: $viewModel.selected, label: Text("Picker")) {
                Text("Follower").tag(listOf.follower)
                Text("Following").tag(listOf.following)
            }
            .pickerStyle(.segmented)
            
            Text(String(viewModel.users.count))
            
            List(viewModel.users){user in
                Text(user.username)
            }
        }
        .padding()
        .onChange(of: viewModel.selected) { newValue in
            viewModel.loadList()
        }
        .onAppear{
            viewModel.loadList()
        }
    }
}

#Preview {
    ContentView()
}
