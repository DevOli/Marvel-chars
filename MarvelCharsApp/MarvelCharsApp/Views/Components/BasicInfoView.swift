//
//  BasicInfoView.swift
//  MarvelCharsApp
//
//  Created by Julio Gabriel Tobares on 06/12/2021.
//

import SwiftUI

struct BasicInfoView: View {
    var character: CharacterModel
    let year = Calendar.current.component(.year, from: Date())

    var body: some View {
        VStack(alignment: .leading) {
            Image("").resizable().frame(width: 20, height: 250, alignment: .center)
            Text("\(character.alterEgo)")
                .foregroundColor(Color(UIColor.primary_white))
                .font(Font(UIFont.profileSubtitle() as CTFont)).padding(.init(top: 10, leading: 25, bottom: 0, trailing: 0))
            Text("\(character.name)")
                .foregroundColor(Color(UIColor.primary_white))
                .font(Font(UIFont.profileTitle() as CTFont)).padding(.init(top: 10, leading: 25, bottom: 0, trailing: 0))
                
            HStack(alignment: .center, spacing: 60) {
                VStack {
                    Image("age").resizable().frame(width: 20, height: 20, alignment: .center).foregroundColor(.white)
                    Text("\(year - Int(character.birth)!) years old")
                        .foregroundColor(Color(UIColor.primary_white))
                        .font(Font(UIFont.characteristics() as CTFont))
                }
                VStack {
                    Image("weight").resizable().frame(width: 20, height: 20, alignment: .center).foregroundColor(.white)
                    Text("\(Int(character.weight)) \(character.weightUnit)")
                        .foregroundColor(Color(UIColor.primary_white))
                        .font(Font(UIFont.characteristics() as CTFont))
                }
                VStack {
                    Image("height").resizable().frame(width: 20, height: 20, alignment: .center).foregroundColor(.white)
                    Text("\(String(format: "%.2f", character.height)) m")
                        .foregroundColor(Color(UIColor.primary_white))
                        .font(Font(UIFont.characteristics() as CTFont))
                }
                VStack {
                    Image("universe").resizable().frame(width: 20, height: 20, alignment: .center).foregroundColor(.white)
                    Text("\(character.universe)")
                        .foregroundColor(Color(UIColor.primary_white))
                        .font(Font(UIFont.characteristics() as CTFont))
                }
            }.padding(.init(top: 30, leading: 40, bottom: 0, trailing: 30)).background(.black)
        }
        VStack{
            Text("\(character.biography)")
                .foregroundColor(Color(UIColor.primary_white))
                .font(Font(UIFont.description() as CTFont)).padding(.init(top: 20, leading: 25, bottom: 0, trailing: 25))
            }.background(.black)
    }
}

