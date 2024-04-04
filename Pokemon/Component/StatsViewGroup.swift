//
//  StatsViewGroup.swift
//  Pokemon
//
//  Created by Martinus Andika Novanawa on 04/04/24.
//

import SwiftUI

struct StatsViewGroup: View {
    var pokemon: Pokemon
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 300, height: 225)
                .foregroundStyle(.white)
                .opacity(0.6)
                .cornerRadius(20)
            
            VStack(alignment: .leading, spacing: 30) {
                StatView(pokemon: pokemon, statName: "Att", statColor: .red, statValue: pokemon.attack)
                StatView(pokemon: pokemon, statName: "Def", statColor: .green, statValue: pokemon.defense)
                StatView(pokemon: pokemon, statName: "Hgt", statColor: .blue, statValue: pokemon.height)
                StatView(pokemon: pokemon, statName: "Wgt", statColor: .yellow, statValue: pokemon.weight)
            }
        }
    }
}

#Preview {
    StatsViewGroup(pokemon: PokemonViewModel().MOCK_POKEMON)
}
