//
//  ContentView.swift
//  HACK A NEWS
//
//  Created by Jason Prosia on 17/05/21.
//

import SwiftUI

struct ContentView: View {
   @ObservedObject var networkManager = NetworkManager()
    
    var body: some View {
        NavigationView{
            List(networkManager.posts) { post in
                HStack{
                    Text(String(post.points))
                    Text(post.title)
                }
            }
            .navigationBarTitle("Hack A News")
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear {
            networkManager.FetchData()
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

