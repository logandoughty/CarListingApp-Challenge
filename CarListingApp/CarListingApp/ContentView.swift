//
//  ContentView.swift
//  CarListingApp
//
//  Created by Logan Doughty on 14/8/2022.
//

import SwiftUI


struct ContentView: View {
    
    @State var vehicles: [Car] = Bundle.main.decode("car_list.json")
    @State var carMakes: [String] = []
    @State var carModels: [String] = []
    @State var filteredCars: [Car] = []
    @State var lastSelection: Int = 0
    @State var filterMake = -1
    @State var filterModel = -1
    
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
                VStack {
                    Image("Tacoma")
                        .resizable()
                        .scaledToFit()
                        .overlay {
                            VStack {
                                Spacer()
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text("Tacoma 2021")
                                            .font(.system(size: 35))
                                            .fontWeight(.bold)
                                            .foregroundColor(.white)
                                        
                                        Text("Get your's now")
                                            .font(.system(size: 24))
                                            .fontWeight(.bold)
                                            .foregroundColor(.white)
                                        
                                    }
                                    Spacer()
                                }
                                .padding(.leading, 20)
                                .padding(.bottom, 30)
                            }
                        }//IMAGE/OVERLAY
                    
                    Form {
                        Section {
                            Picker("Any Make", selection: $filterMake) {
                                Text("Any Make").tag(-1)
                                ForEach(carMakes.indices, id: \.self) { i in
                                    Text(carMakes[i]).tag(i)
                                }
                            }
                            .pickerStyle(.menu)
                            .onChange(of: filterMake) { val in
                                filterModel = -1
                                filteredCars = []
                                if val == -1 {
                                    filteredCars = vehicles
                                    for car in vehicles {
                                        if !carModels.contains(car.model) {
                                            carModels.append(car.model)
                                        }
                                    }
                                } else {
                                    carModels = []
                                    filteredCars = vehicles.filter({$0.make == carMakes[filterMake]})
                                    for car in vehicles {
                                        if car.make == carMakes[val] {
                                            carModels.append(car.model)
                                        }
                                    }
                                }
                            }
                            
                            Picker("Any Model", selection: $filterModel) {
                                Text("Any Model").tag(-1)
                                
                                ForEach(carModels.indices, id: \.self) { i in
                                    Text(carModels[i]).tag(i)
                                }
                            }
                            .pickerStyle(.menu)
                            .onChange(of: filterModel){ val in
                                filteredCars = []
                                if val == -1 {
                                    filteredCars = vehicles.filter({$0.make == carMakes[filterMake]})
                                } else {
                                    filteredCars = vehicles.filter({$0.model == carModels[filterModel]})
                                }
                            }
                            
                            
                        } header: {
                            Text("Filter")
                                .font(.title)
                                .fontWeight(.bold)
                        }
                        .headerProminence(.increased)
                    }
                    .frame(height: 200) //FORM
                    
                    LazyVStack(spacing: 40) {
                        
                        ForEach(0..<filteredCars.count, id: \.self) { index in
                            CardView(car: $filteredCars[index], index: index, lastSelected: $lastSelection)
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
                        .onChange(of: filteredCars) { _ in
                            lastSelection = 0
                        }
                    }//LazyVStack
                }//VSTACK
                .onAppear {
                    filteredCars = vehicles
                    for car in vehicles {
                        if !carMakes.contains(car.make) {
                            carMakes.append(car.make)
                        }
                    }
                }
            }//SCROLLVIEW
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
        }//NAV
    }//BODY
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
