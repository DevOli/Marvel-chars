//  TextHelper.swift
//  MarvelCharsApp
//
//  Created by User on 3/12/21.
//

import Foundation
import SwiftUI

extension Text {
    func abilitiesStyles() -> some View {
        self.foregroundColor(Color(UIColor.primaryWhite))
            .frame(width: 110, alignment: .leading)
            .font(Font(UIFont.ability() as CTFont))
    }
}
