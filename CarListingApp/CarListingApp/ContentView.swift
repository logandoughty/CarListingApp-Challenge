//
//  ContentView.swift
//  CarListingApp
//
//  Created by Logan Doughty on 14/8/2022.
//

import SwiftUI

struct Car: Codable, Hashable {
    var consList: [String]
    var customerPrice: Double
    var make: String
    var marketPrice: Double
    var model: String
    var prosList: [String]
    var rating: Int
    
    var listingName: String {
        make + " " + model
    }
    
    var image: String {
        let carMake = make.replacingOccurrences(of: " ", with: "_")
        let carModel = model.replacingOccurrences(of: " ", with: "_")
        return carMake + "_" + carModel
    }
    
}

struct ContentView: View {
    
    @State var vehicles: [Car] = Bundle.main.decode("car_list.json")
    @State var lastSelection: Int = 0
    
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .orange

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        
        
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 30) {
                    ForEach(vehicles.indices, id: \.self) { index in
                        CardView(car: vehicles[index], index: index, lastSelected: $lastSelection)
                            .padding()
                            .transaction { transaction in
                                transaction.animation = .spring()
                            }
                            
                        
                        Divider()
                            .frame(width: 200, height: 2)
                            .overlay(.orange)
                            .transaction { transaction in
                                transaction.animation = .spring()
                            }
                    }
                    Spacer()
                }
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("GUIDOMA")
                        .font(.system(size: 25))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.bottom)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        
                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .resizable()
                            .scaledToFill()
                            .foregroundColor(.white)
                            .frame(width: 15, height: 15)
                            .padding(.trailing, 10)
                            .padding(.bottom)
                        
                    }
                }
            }//TOOLBAR
        }
    }
    
    //MARK: FUNCTIONS

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
