//
//  ContentView.swift
//  YoriJori
//
//  Created by forest on 2023/06/06.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            RecipeBookListView()
                .tabItem { Image(systemName: "books.vertical") }
            WriteRecipeView()
                .tabItem { Image(systemName: "pencil.line") }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
    
