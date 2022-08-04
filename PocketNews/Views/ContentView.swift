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
    @State var tagSelection = ["Top Stories", "Ask HN", "Show HN"]
    
    //MARK: - FilterButton style
    struct FilterButton: ButtonStyle {
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .foregroundColor(Color("ButtonForegroundColor"))
                .background(RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(Color("ButtonBackgroundColor"))
                    .frame(width: 100, height: 30))
                .padding(.leading, 20)
        }
    }
    
    var body: some View {
        NavigationView {
            //MARK: - List
            VStack {
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
                .toolbar {
                    Picker(
                        selection: $tagSelection,
                        label: Text("Picker")) {
                            ForEach(tagSelection { selection in
                                Text(selection)
                                    .tag(selection)
                            })
                        }
                        .pickerStyle(MenuPickerStyle())
                }
                .navigationTitle("PocketNews")
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
