//
//  PokemonImage.swift
//  Pokemon
//
//  Created by Martinus Andika Novanawa on 04/04/24.
//

import SwiftUI
import Kingfisher

struct PokemonImage: View {
    var image: KFImage
    
    var body: some View {
        image
            .resizable()
            .scaledToFill()
            .frame(width: 200, height: 200)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 5))
            .background(Circle().foregroundStyle(.white))
            .shadow(radius: 5)
    }
}

#Preview {
    PokemonImage(image: KFImage(URL(string: PokemonViewModel().MOCK_POKEMON.imageUrl)))
}
