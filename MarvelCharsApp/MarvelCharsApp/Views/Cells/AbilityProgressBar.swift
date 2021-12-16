//
//  AbilityProgressBar.swift
//  MarvelCharsApp
//
//  Created by User on 3/12/21.
//

import SwiftUI

struct AbilityProgressBar: View {
    var percent: CGFloat

    var body: some View {
        let multiplier: CGFloat = percent/100

        ZStack(alignment: .leading) {
            Color(.black)
            GeometryReader { geometry in
                Path { path in
                    path.move(to: CGPoint(x: 0, y: geometry.size.height / 2))
                    path.addLine(to: CGPoint(x: geometry.size.width, y:  geometry.size.height / 2))
                }
                .stroke(style: StrokeStyle( lineWidth: 12, dash: [2, 7]))
                .foregroundColor(Color(UIColor.gray))
            }

            GeometryReader { geometry in
                Path { path in
                    path.move(to: CGPoint(x: 0, y: geometry.size.height / 2))
                    path.addLine(to: CGPoint(x: geometry.size.width * multiplier, y: geometry.size.height / 2))
                }
                .stroke(style: StrokeStyle( lineWidth: 12, dash: [2, 7]))
                .foregroundColor(Color(UIColor.primary_white))
            }
            
            GeometryReader { geometry in
                Path { path in
                    path.move(to: CGPoint(x: (geometry.size.width * multiplier)-1, y: geometry.size.height / 2))
                    path.addLine(to: CGPoint(x: (geometry.size.width * multiplier)+1, y: geometry.size.height / 2))
                }
                .stroke(style: StrokeStyle( lineWidth: 18, dash: [2, 7]))
                .foregroundColor(Color(UIColor.primary_white))
            }
        }
    }
}

struct AbilityProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        AbilityProgressBar(percent: 0.0)
    }
}
