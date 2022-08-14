//
//  CardView.swift
//  CarListingApp
//
//  Created by Logan Doughty on 14/8/2022.
//

import SwiftUI

struct CardView: View {
    //MARK: PROPERTIES
    var car: Car
    var index: Int
    
    @State var isShowingCard = false
    @Binding var lastSelected: Int
    
    var body: some View {
        VStack {
            //Disclosure Group
            DisclosureGroup(isExpanded: $isShowingCard) {
                HStack {
                    VStack(alignment: .leading) {
                            //PROS
                            HStack {
                                Image(systemName: "circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 5)
                                    .foregroundColor(.orange)
                                Text("PROS:")
                                    .font(.headline)
                            }
                            if car.prosList.isEmpty {
                                HStack{
                                    Image(systemName: "circle.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 5)
                                        .foregroundColor(.orange)
                                    Text("N/A")
                                }
                                .padding(.leading, 20)
                            } else {
                                ForEach(car.prosList, id: \.self){ item in
                                    if item.count > 0 {
                                        HStack {
                                            Image(systemName: "circle.fill")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 5)
                                                .foregroundColor(.orange)
                                            Text(item)
                                        }
                                        .padding(.leading, 20)
                                    }
                                }
                            }
                            
                            
                            //CONS
                            HStack {
                                Image(systemName: "circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 5)
                                    .foregroundColor(.orange)
                                Text("CONS:")
                                    .font(.headline)
                            }
                            if car.consList.isEmpty {
                                HStack{
                                    Image(systemName: "circle.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 5)
                                        .foregroundColor(.orange)
                                    Text("N/A")
                                }
                                .padding(.leading, 20)
                            } else {
                                ForEach(car.consList, id: \.self){ item in
                                    if item.count > 0 {
                                        HStack {
                                            Image(systemName: "circle.fill")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 5)
                                                .foregroundColor(.orange)
                                            Text(item)
                                        }
                                        .padding(.leading, 20)
                                    }
                                }
                            }
                    }
                    .padding()
                    Spacer()
                }//HSTACK
                .onTapGesture {
                    isShowingCard.toggle()
                }
            } label: {
                    VStack(alignment: .leading) {
                        HStack {
                            Image(car.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 80)
                                
                                VStack(alignment: .leading) {
                                    Text(car.listingName)
                                        .font(.system(size: 20))
                                        .fontWeight(.bold)
                                        .multilineTextAlignment(.leading)
                                        
                                    
                                    Text(String(format: "Price: $%.0f", car.customerPrice))
                                        .font(.headline)
                                        

                                    Spacer()
                                    StarRatingView(rating: car.rating)
                                }
                                .padding(.leading, 10)
                                .frame(height: 80)
                        }//HSTACK
                    }//VSTACK
                    .onTapGesture {
                        isShowingCard.toggle()
                        lastSelected = index
                    }
            }//DISCLOSUREGROUP
            .buttonStyle(PlainButtonStyle())
            .accentColor(.clear)
        }
        .onAppear {
            if index == 0 && lastSelected == 0 {
                isShowingCard = true
            } else if index != lastSelected {
                isShowingCard = false
            }
        }
        .onChange(of: lastSelected) { val in
            if val != index {
                isShowingCard = false
            }
        }
    }
    
}

struct CardView_Previews: PreviewProvider {
    static var vehicles: [Car] = Bundle.main.decode("car_list.json")
    
    static var previews: some View {
        CardView(car: vehicles[0], index: 0, isShowingCard: true, lastSelected: .constant(1))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
