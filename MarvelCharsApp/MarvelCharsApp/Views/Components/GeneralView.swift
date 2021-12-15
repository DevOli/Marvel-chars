//
//  GeneralView.swift
//  MarvelCharsApp
//
//  Created by Julio Gabriel Tobares on 06/12/2021.
//

import SwiftUI

struct GeneralView: View {
    var character: CharacterModel
    var body: some View {
        ZStack {
            Image("\(character.imagePath)").resizable().scaledToFill().edgesIgnoringSafeArea(.all)
            Rectangle().foregroundColor(.clear).background(LinearGradient(gradient:
                                                                            Gradient(colors: [.clear, .black]),
                                                                          startPoint: .top, endPoint: .bottom))
            Rectangle().foregroundColor(.clear).background(LinearGradient(gradient:
                                                                            Gradient(colors: [.clear, .black]),
                                                                          startPoint: .top, endPoint: .bottomTrailing))
                VStack(alignment: .leading, spacing: 0) {
                    BasicInfoView(character: character)
                    AbilitiesView(character: character)
                }.padding()
        }
    }
}
