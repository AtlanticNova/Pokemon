//
//  PokemonListView.swift
//  Pokemon
//
//  Created by Martinus Andika Novanawa on 04/04/24.
//

import SwiftUI
import Kingfisher

struct PokemonListView: View {
    @ObservedObject var pokemonVM = PokemonViewModel()
    @State private var searchText = ""
    @ObservedObject var pokemonData: PokemonData
    
    var filteredPokemon: [Pokemon] {
        if searchText == "" { return pokemonVM.pokemon }
        return pokemonVM.pokemon.filter {
            $0.name.lowercased().contains(searchText.lowercased())
        }
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
                                    if poke.isFavorite {
                                        Image(systemName: "star.fill")
                                            .foregroundStyle(.yellow)
                                    }
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
                        Button(action: { addFavorite(pokemon: poke)}) {
                            Image(systemName: "star")
                        }
                        .tint(.yellow)
                        
                        Button(action: { toggleCapture(pokemon: poke)}) {
                            if poke.isCaptured {
                                Image(systemName: "figure.wave")
                                    .tint(.blue)
                            } else {
                                Image(systemName: "figure.handball")
                                    .tint(.red)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Pokemon")
            .searchable(text: $searchText)
        }
    }
    
    func addFavorite(pokemon: Pokemon) {
        if let index = pokemonVM.pokemon.firstIndex(where: { $0.id == pokemon.id }) {
            pokemonVM.pokemon[index].isFavorite.toggle()
        }
    }
    
    func toggleCapture(pokemon: Pokemon) {
        if let index = pokemonVM.pokemon.firstIndex(where: { $0.id == pokemon.id }) {
            pokemonVM.pokemon[index].isCaptured.toggle()
            if pokemonVM.pokemon[index].isCaptured {
                pokemonData.capturedPokemon.append(pokemonVM.pokemon[index])
//                pokemonData.capturedPokemon.removeAll { $0.id == pokemon.id }
            } else {
                pokemonData.capturedPokemon.removeAll { $0.id == pokemon.id }
//                pokemonData.capturedPokemon.append(pokemonVM.pokemon[index])
            }
        }
    }
}

#Preview {
    PokemonListView(pokemonData: PokemonData())
}
