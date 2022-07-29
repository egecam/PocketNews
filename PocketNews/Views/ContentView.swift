//
//  ContentView.swift
//  PocketNews
//
//  Created by Ege Çam on 16.07.2022.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var networkManager = NetworkManager()
    
    @State var tag = "front_page"
    
    //MARK: - FilterButton style
    struct FilterButton: ButtonStyle {
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .foregroundColor(.white)
                .background(RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(.black)
                    .frame(width: 100, height: 30))
                .padding(.leading, 20)
        }
    }
    
    var body: some View {
        NavigationView {
            
            VStack {
                //MARK: - Filter buttons
                HStack {
                    Button("Top Stories") {
                        changeFilter(to: "front_page")
                    }
                    .buttonStyle(FilterButton())
                    
                    Spacer()
                    
                    Button("Ask HN") {
                        changeFilter(to: "ask_hn")
                    }
                    .buttonStyle(FilterButton())
                    
                    Spacer()
                    
                    Button("Show HN") {
                        changeFilter(to: "show_hn")
                    }
                    .buttonStyle(FilterButton())
                    
                    Spacer()
                }
                
                //MARK: - List
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
                    .navigationTitle("PocketNews")
                }
                .refreshable {
                    //TODO: Add GhostLoader animation
                    self.networkManager.fetchData(tags: tag)
                }
            }
        }
        .onAppear {
            self.networkManager.fetchData(tags: tag)
        }
        
    }
    
    func changeFilter(to: String) {
        self.tag = to
        self.networkManager.fetchData(tags: tag)
        //TODO: Move function to an external model
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
