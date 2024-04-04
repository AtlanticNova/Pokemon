//
//  StatView.swift
//  Pokemon
//
//  Created by Martinus Andika Novanawa on 04/04/24.
//

import SwiftUI

struct StatView: View {
    var pokemon: Pokemon
    var statName: String
    var statColor: Color
    var statValue: Int
    
    var body: some View {
        HStack {
            Text(statName)
                .font(.system(.body, design: .monospaced))
            
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 5)
                    .foregroundStyle(.gray)
                    .frame(width: 150, height: 20)
                
                RoundedRectangle(cornerRadius: 5)
                    .foregroundStyle(statColor)
                    .frame(width: statValue <= 100 ? 150 * (CGFloat(statValue) / 100) : 150, height: 20)
            }
            Text("\(statValue)")
                .font(.system(.body, design: .monospaced))
        }
    }
}

#Preview {
    StatView(pokemon: PokemonViewModel().MOCK_POKEMON, statName: "Atk", statColor: .blue, statValue: 10)
}
