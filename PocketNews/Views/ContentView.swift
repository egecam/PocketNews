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
                        .navigationTitle("PocketNews")
                        
                    }
                    
                }
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarLeading) {
                        Button("Top Stories") {
                            print("one")
                        }
                        .background(.blue)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                        
                        Button("Ask HN") {
                            print("two")
                        }
                        
                        Button("Show HN") {
                            print("two")
                        }
                        
                        Button("Last 24h") {
                            print("two")
                        }
                    }
                }
                .refreshable {
                    self.networkManager.fetchData()
            }
            
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
