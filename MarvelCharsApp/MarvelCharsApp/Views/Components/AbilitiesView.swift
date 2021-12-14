//
//  AbilitiesView.swift
//  MarvelCharsApp
//
//  Created by User on 3/12/21.
//

import SwiftUI

struct AbilitiesView: View {
    var character: CharacterModel
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color(.black)
            VStack(alignment: .leading, spacing: 30) {
                Text("Abilities")
                    .foregroundColor(Color(UIColor.primaryWhite))
                    .font(Font(UIFont.sectionTitle() as CTFont))
                HStack {
                    Text("Force").abilitiesStyles()
                    AbilityProgressBar(percent: CGFloat(character.force))
                }
                HStack {
                    Text("Intelligence").abilitiesStyles()
                    AbilityProgressBar(percent: CGFloat(character.intelligence))
                }
                HStack {
                    Text("Agility").abilitiesStyles()
                    AbilityProgressBar(percent: CGFloat(character.agility))
                }
                HStack {
                    Text("Endurance").abilitiesStyles()
                    AbilityProgressBar(percent: CGFloat(character.endurance))
                }
                HStack {
                    Text("Velocity").abilitiesStyles()
                    AbilityProgressBar(percent: CGFloat(character.velocity))
                }
            }.padding(.init(top: 10, leading: 25, bottom: 10, trailing: 40))
        }
    }
} 
