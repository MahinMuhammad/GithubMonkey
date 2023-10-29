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
            Text("People does not follow back: \(String(viewModel.usersNotFollowers.count))")
            
            List(viewModel.usersNotFollowers){user in
                Text(user.username)
            }
            .listStyle(.plain)
        }
        .padding()
        .onAppear{
            viewModel.loadList()
        }
    }
}

#Preview {
    ContentView()
}
