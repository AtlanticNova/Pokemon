//
//  PokemonDetailView.swift
//  Pokemon
//
//  Created by Martinus Andika Novanawa on 04/04/24.
//

import SwiftUI
import Kingfisher

struct PokemonDetailView: View {
    var pokemon: Pokemon
    @State private var scale: CGFloat = 0
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    Text(pokemon.name.capitalized)
                        .font(.largeTitle)
                        .bold()
                    Text(pokemon.type.capitalized)
                        .italic()
                        .foregroundStyle(pokemon.typeColor)
                    
                    PokemonImage(image: KFImage(URL(string: pokemon.imageUrl)))
                        .padding(.bottom, -125)
                        .zIndex(1)
                    
                    ZStack {
                        Rectangle()
                            .ignoresSafeArea(.all)
                            .frame(width: geo.size.width, height: geo.size.height)
                            .foregroundStyle(pokemon.typeColor)
                        
                        VStack {
                            HStack {
                                if pokemon.isFavorite {
                                    Label("Favorite", systemImage: "star.fill")
                                        .foregroundStyle(pokemon.typeColor)
                                        .padding(5)
                                        .background(Capsule().foregroundStyle(.white))
                                }
                                
                                if pokemon.isCaptured {
                                    Label("Capture", systemImage: "cricket.ball.fill")
                                        .foregroundStyle(pokemon.typeColor)
                                        .padding(5)
                                        .background(Capsule().foregroundStyle(.white))
                                }
                            }
                            
                            Text(pokemon.description.replacingOccurrences(of: "\n", with: ""))
                                .foregroundStyle(.white)
                                .padding()
                            StatsViewGroup(pokemon: pokemon)
                        }
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

#Preview {
    PokemonDetailView(pokemon: PokemonViewModel().MOCK_POKEMON)
}
