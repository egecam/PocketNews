//
//  StoryView.swift
//  PocketNews
//
//  Created by Ege Çam on 29.07.2022.
//

import SwiftUI

struct StoryView: View {
    
    let title: String?
    let author: String?
    let points: Int?
    let story_text: String?
    
    
    var body: some View {
        Text("Hello world!")
    }
}

struct StoryView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StoryView(title: "hey", author: "naber", points: 9, story_text: "yo")
        }
    }
}
