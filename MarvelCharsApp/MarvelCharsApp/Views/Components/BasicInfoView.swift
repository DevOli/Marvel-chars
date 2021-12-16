//
//  BasicInfoView.swift
//  MarvelCharsApp
//
//  Created by Julio Gabriel Tobares on 08/12/2021.
// 

import SwiftUI
struct BasicInfoView: View {
    var character: CharacterModel
    let year = Calendar.current.component(.year, from: Date())
    var body: some View {
        ZStack(alignment: .topLeading) {
          AsyncImage(url: URL(string: character.imagePath)) { phase in
            switch phase {
            case .empty:
              ProgressView()
            case .success(let image):
              image.resizable()
            case .failure:
              Image(systemName: "photo")
            @unknown default:
              // Handler for future cases that might be added
              EmptyView()
            }
          }
            Rectangle().foregroundColor(.clear).background(LinearGradient(gradient: Gradient(colors: [.clear, .black]), startPoint: .top, endPoint: .bottom))
            Rectangle().foregroundColor(.clear).background(LinearGradient(gradient: Gradient(colors: [.clear, .black]), startPoint: .top, endPoint: .bottomTrailing))
            VStack(alignment: .leading) {
                    Spacer()
                    Text("\(character.alterEgo)")
                        .foregroundColor(Color(UIColor.primaryWhite))
                        .font(Font(UIFont.profileSubtitle() as CTFont))
                        .padding(.init(top: 10, leading: 25, bottom: 0, trailing: 0))
                    Text("\(character.name)")
                        .foregroundColor(Color(UIColor.primaryWhite))
                        .font(Font(UIFont.profileTitle() as CTFont))
                        .padding(.init(top: 10, leading: 25, bottom: 0, trailing: 0))
                    HStack(alignment: .center, spacing: 50) {
                        VStack {
                            Image("age").resizable().frame(width: 20, height: 20,
                                                           alignment: .center).foregroundColor(.white)
                            Text("\(year - Int(character.birth)!) years old")
                                .foregroundColor(Color(UIColor.primaryWhite))
                                .font(Font(UIFont.characteristics() as CTFont))
                        }
                        VStack {
                            Image("weight").resizable().frame(width: 20, height: 20,
                                                              alignment: .center).foregroundColor(.white)
                            Text("\(Int(character.weight)) \(character.weightUnit)")
                                .foregroundColor(Color(UIColor.primaryWhite))
                                .font(Font(UIFont.characteristics() as CTFont))
                        }
                        VStack {
                            Image("height").resizable().frame(width: 20, height: 20,
                                                              alignment: .center).foregroundColor(.white)
                            Text("\(String(format: "%.2f", character.height)) m")
                                .foregroundColor(Color(UIColor.primaryWhite))
                                .font(Font(UIFont.characteristics() as CTFont))
                        }
                        VStack {
                            Image("universe").resizable().frame(width: 20, height: 20,
                                                                alignment: .center).foregroundColor(.white)
                            Text("\(character.universe)")
                                .foregroundColor(Color(UIColor.primaryWhite))
                                .font(Font(UIFont.characteristics() as CTFont))
                        }
                    }.padding(.init(top: 30, leading: 40, bottom: 0, trailing: 30))
                    Text("\(character.biography)")
                        .foregroundColor(Color(UIColor.primaryWhite))
                        .font(Font(UIFont.description() as
                                   CTFont)).padding(.init(top: 20, leading: 25, bottom: 0, trailing: 25))
             }.padding(.init(top: 0, leading: 0, bottom: 15, trailing: 0))
        }
    }
}

struct BasicInfoView_Previews: PreviewProvider {
    static var previews: some View {
        BasicInfoView(character: CharacterModel(name: "Spiderman", alterEgo: "Peter Parker",
                                                imagePath: "spider-man", biography: "This is a test Bio",
                                                birth: "1990", weight: 78, weightUnit: "kg", height: 1.8,
                                                heightUnit: "meters", universe: "earth 616", force: 70,
                                                intelligence: 65, agility: 90, endurance: 60, velocity: 80, movies: [
            "captain-america-3",
            "spider-man-homecoming",
            "avengers-3",
            "avengers-4",
            "spider-man-far-from-home",
            "spider-man-1",
            "spider-man-2",
            "spider-man-3"]
        ))
    }
}
