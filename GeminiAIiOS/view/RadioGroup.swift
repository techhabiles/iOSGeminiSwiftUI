//
//  RadioGroup.swift
//  GeminiAIiOS
//
//  Created by @TechHabiles on 31/12/23.
//

/**
 * Radio Group Custom Component to create radio groups
 */
import SwiftUI

struct RadioGroup: View {
    enum Orientation{
        case Vertical
        case Horizontal
    }
    @State var options:[String] = []
    @State var orientation = Orientation.Horizontal
    @Binding var selection: String
    
    var body: some View {
        switch orientation {
        case .Horizontal :
            HStack{
                ForEach(options, id: \.self){ item in
                    RatioItem(item: item, selection: $selection)
                }
            }
        case .Vertical :
            VStack{
                // To be implemented
            }
        }
        
    }
}

/**
 * Individual Radio Item or a group
 */
struct RatioItem: View {
    @State var item: String
    @Binding var selection: String
    var body: some View {
        HStack(spacing: 10){
            if( selection == item) {
                Image(systemName: "circle.fill").foregroundColor(.green)
            }else{
                Image(systemName: "circle").foregroundColor(.red)
            }
            Text(item).font(.headline)
        }.onTapGesture {
            selection = item
        }
    }
}

