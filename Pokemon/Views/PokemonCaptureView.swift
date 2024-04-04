//
//  PokemonCaptureView.swift
//  Pokemon
//
//  Created by Martinus Andika Novanawa on 04/04/24.
//

import SwiftUI
import Kingfisher

struct PokemonCaptureView: View {
    @ObservedObject var pokemonVM = PokemonViewModel()
    @State private var searchText = ""
    @ObservedObject var pokemonData: PokemonData
    
    var filteredPokemon: [Pokemon] {
        return pokemonData.capturedPokemon
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredPokemon) { poke in
                    NavigationLink(destination: PokemonDetailView(pokemon: poke)) {
                        HStack {
                            VStack (alignment: .leading, spacing: 5) {
                                HStack {
                                    Text(poke.name.capitalized)
                                        .font(.title)
                                    if poke.isCaptured {
                                        Image(systemName: "cricket.ball.fill")
                                            .foregroundStyle(.red)
                                    }
                                }
                                
                                HStack {
                                    Text(poke.type.capitalized)
                                        .italic()
                                    Circle()
                                        .foregroundStyle(poke.typeColor)
                                        .frame(width: 10, height: 10)
                                }
                                Text(poke.description)
                                    .font(.caption)
                                    .lineLimit(2)
                            }
                            
                            Spacer()
                            
                            KFImage(URL(string: poke.imageUrl))
                                .interpolation(.none)
                                .resizable()
                                .frame(width: 100, height: 100)
                        }
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                        Button(action: { uncapture(pokemon: poke)}) {
                            Image(systemName: "figure.wave")
                        }
                        .tint(.blue)
                    }
                }
            }
            .navigationTitle("Captured Pokemon")
        }
    }
    
    func uncapture(pokemon: Pokemon) {
        if pokemonVM.pokemon.firstIndex(where: { $0.id == pokemon.id }) != nil {
            pokemonData.capturedPokemon.removeAll { $0.id == pokemon.id }
        }
    }
}

#Preview {
    PokemonCaptureView(pokemonData: PokemonData())
}
