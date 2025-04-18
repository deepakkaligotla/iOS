//
//  HOSOptionsView.swift
//  FlyWeis
//
//  Created by Deepak Kaligotla on 14/08/24.
//

import SwiftUI

struct HOSOptionsView: View {
    @State private var selectedCountry: Country = Country(name: "United States", code: "USA", flag: "🇺🇸")
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    VStack {
                        Menu {
                            ForEach(countries, id: \.code) { country in
                                Button(action: {
                                    selectedCountry = country
                                }) {
                                    HStack {
                                        Text("\(country.flag) \(country.name)")
                                            .font(.body)
                                            .bold()
                                            .padding(.leading, 8)
                                            .lineLimit(1)
                                    }
                                    .padding(8)
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                                }
                            }
                        } label: {
                            HStack {
                                Text(selectedCountry.flag)
                                    .font(.system(size: 40))
                                Text(selectedCountry.code)
                                    .font(.body)
                                    .bold()
                                    .padding(.leading, 8)
                                    .foregroundColor(.white)
                            }
                            .padding()
                            .background(SelectionShapeStyle())
                            .cornerRadius(8)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    HOSOptionsView()
}
