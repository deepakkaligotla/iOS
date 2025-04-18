//
//  Form.swift
//  SwiftCharts
//
//  Created by Deepak Kaligotla on 17/05/24.
//

import SwiftUI
import SwiftData

struct FormView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var places: [Place]
    @Query private var addresses: [Address]
    @State private var contextualPaletteAnchor: PopoverAttachmentAnchor?
    @State private var newPlaceName: String = ""
    @State private var selectedAddress: Address? = nil
    @State private var newPlaceType: PlaceType? = nil
    @State private var newAddressType: AddressType? = nil
    @State private var newRating: Double = 0.0
    @State private var searchPincode: String = ""
    @State private var showResult = false
    @State private var showList = false
    @State private var searchResult: [Address] = []
    
    var body: some View {
        NavigationSplitView {
            VStack {
                Form {
                    Section(header: Text("Create new place in DB")) {
                        if let selectedAddress = selectedAddress {
                            Text("\(selectedAddress.area), \(selectedAddress.taluk), \(selectedAddress.district), \(selectedAddress.state) - \(String(selectedAddress.pincode))")
                                .onLongPressGesture {
                                    self.selectedAddress = nil
                                }
                        } else {
                            TextField("Search Pincode", text: $searchPincode)
                                .textFieldStyle(PlainTextFieldStyle())
                                .keyboardType(.numberPad)
                                .onChange(of: searchPincode) { newValue in
                                    if newValue.count == 6 {
                                        self.fetchData(for: searchPincode)
                                        UIApplication.shared.endEditing()
                                        self.showResult.toggle()
                                    }
                                }.popover(isPresented: $showResult, attachmentAnchor: .point(.bottomTrailing)) {
                                    if searchResult.isEmpty {
                                        Text("INVALID PINCODE").foregroundColor(.gray)
                                            .presentationCompactAdaptation(.popover)
                                    } else {
                                        List(searchResult) { address in
                                            Text("\(address.area), \(address.taluk), \(address.district), \(address.state) - \(String(address.pincode))").font(.caption)
                                                .onTapGesture {
                                                    self.selectedAddress = address
                                                    self.showResult.toggle()
                                                }
                                        }
                                        .frame(minWidth: 250, maxWidth: 250, minHeight: 400)
                                        .presentationCompactAdaptation(horizontal: .none, vertical: .popover)
                                    }
                                }
                        }
                        
                        TextField(text: $newPlaceName, prompt: Text("Place name")) {
                            Text("Place name")
                        }
                        
                        Picker("Select Place Type", selection: $newPlaceType) {
                            Text("Select Place Type").tag(nil as PlaceType?)
                            ForEach(PlaceType.allCases, id: \.self) { placeType in
                                Text(placeType.rawValue).tag(placeType as PlaceType?)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        
                        Picker("Select Address Type", selection: $newAddressType) {
                            Text("Select Address Type").tag(nil as AddressType?)
                            ForEach(AddressType.allCases, id: \.self) { addressType in
                                Text(addressType.rawValue).tag(addressType as AddressType?)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        
                        HStack(spacing:10) {
                            SetRatingStars(value: $newRating, stars: 5).frame(width: 200, height: 40, alignment: .center)
                            Circle()
                                .fill(.clear)
                                .stroke(.white, lineWidth: 1)
                                .frame(width: 40, height: 40, alignment: .center)
                                .overlay(
                                    Text("\(newRating, specifier: "%.2F")")
                                        .foregroundColor(.white)
                                        .fontWeight(.bold)
                                )
                        }
                        
                        Button(action: {
                            self.addPlace(
                                add_place_name: newPlaceName,
                                add_place_Type: newPlaceType,
                                add_address_type: newAddressType)
                        }) {
                            Text("Add New Place")
                        }
                        .buttonStyle(BorderedButtonStyle())
                        .disabled(newPlaceName == "" && newPlaceType == nil && newAddressType == nil)
                    }
                }
                .navigationTitle("Charts Data")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Places List", systemImage: "list.bullet.below.rectangle") {
                            self.showList.toggle()
                        }.popover(isPresented: $showList) {
                            PlacesList()
                                .frame(minWidth: 250, maxWidth: 250, minHeight: 150, maxHeight: 400)
                                .presentationCompactAdaptation(.popover)
                        }
                    }
                }
            }
        } detail: {
            
        }
    }
    
    private func addPlace(add_place_name: String, add_place_Type: PlaceType?, add_address_type: AddressType?) {
        withAnimation {
            guard let newPlaceType = newPlaceType, let newAddressType = newAddressType, let selectedAddress = selectedAddress else {
                print("Error")
                return
            }
            let newPlace = Place(
                new_place_name: add_place_name,
                new_place_address: selectedAddress,
                new_place_type: newPlaceType.rawValue,
                new_address_type: newAddressType.rawValue,
                new_rating: newRating)
            modelContext.insert(newPlace)
        }
    }
    
    func fetchData(for searchPincode: String) {
        let apiUrl = URL(string: "http://3.145.141.103:4000/pincode/\(searchPincode)")!
        URLSession.shared.dataTask(with: apiUrl) { data, response, error in
            guard let data = data else {
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            do {
                print(data)
                let addresses = try JSONDecoder().decode([Address].self, from: data)
                DispatchQueue.main.async {
                    self.searchResult = addresses
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
    }
}

struct PlacesList: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var places: [Place]
    
    var body: some View {
        VStack {
            List {
                GeometryReader { geoReader in
                    HStack {
                        VStack(alignment: .leading) {
                            Text("ID")
                        }
                        .frame(width: geoReader.size.width / 3.6, height: geoReader.size.height, alignment: .leading)
                        
                        VStack(alignment: .center) {
                            Text("Name")
                        }
                        .frame(width: geoReader.size.width / 3.5, height: geoReader.size.height, alignment: .center)
                        
                        VStack(alignment: .trailing) {
                            Text("Rating")
                        }
                        .frame(width: geoReader.size.width / 3.6, height: geoReader.size.height, alignment: .trailing)
                    }
                }
                ForEach(places) { place in
                    NavigationLink {
                        Text("Place Name - \(place.place_name)")
                        Text("Place Type - \(place.place_type)")
                        Text("Address type - \(place.address_type)")
                        Text("Address - \(place.place_address.area), \(place.place_address.taluk), \(place.place_address.district), \(place.place_address.state) - \(String(place.place_address.pincode))")
                        Text("Rating - \(place.rating, specifier: "%.2F")/5.00")
                        GetRatingStars(value: place.rating, stars: 5).frame(width: 200, height: 40, alignment: .center)
                    } label: {
                        GeometryReader { geoReader in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("\(place.place_id)")
                                }
                                .frame(width: geoReader.size.width / 3.5, height: geoReader.size.height, alignment: .leading)
                                
                                VStack(alignment: .center) {
                                    Text("\(place.place_name)")
                                }
                                .frame(width: geoReader.size.width / 3.5, height: geoReader.size.height, alignment: .center)
                                
                                VStack(alignment: .trailing) {
                                    Text("\(place.rating, specifier: "%.2F")")
                                }
                                .frame(width: geoReader.size.width / 3.5, height: geoReader.size.height, alignment: .trailing)
                            }
                        }
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    EditButton()
                }
            }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(places[index])
            }
        }
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
