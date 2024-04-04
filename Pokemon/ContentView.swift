//
//  ContentView.swift
//  Pokemon
//
//  Created by Martinus Andika Novanawa on 02/04/24.
//

import SwiftUI
import Kingfisher

struct ContentView: View {
    @ObservedObject var pokemonVM = PokemonViewModel()
    @ObservedObject var pokemonData = PokemonData()
    
    var body: some View {
        TabView {
            PokemonListView(pokemonData: pokemonData)
                .tabItem {
                    Label("Menu", systemImage: "list.dash")
                }
            
            PokemonCaptureView(pokemonData: pokemonData)
                .tabItem {
                    Label("My Pokemon List", systemImage: "cricket.ball.fill")
                }
        }
    }
}

#Preview {
    ContentView()
}
