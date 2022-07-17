//
//  ContentView.swift
//  PocketNews
//
//  Created by Ege Çam on 16.07.2022.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var networkManager = NetworkManager()
    
    var body: some View {
        NavigationView {
            List(networkManager.posts) { post in
                NavigationLink(destination: DetailView(url: post.url)) {
                    VStack {
                        HStack {
                            Text(post.title)
                                .font(.subheadline)
                                .fontWeight(.bold)
                            Spacer()
                        }
                        .lineLimit(3)
                        HStack {
                            Text(String(post.points))
                                .fontWeight(.light)
                            Text(post.author)
                                .fontWeight(.light)
                            Spacer()
                        }
                        
                    }
                }
                
            }
            .navigationTitle("Pocket News")
        }
        .onAppear {
            self.networkManager.fetchData()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//let posts = [
//    Post(id: "1", title: "Hello"),
//    Post(id: "2", title: "Bonjour"),
//    Post(id: "3", title: "Merhaba")
//]
