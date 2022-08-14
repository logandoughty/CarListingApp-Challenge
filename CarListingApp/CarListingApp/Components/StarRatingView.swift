//
//  StarRatingView.swift
//  CarListingApp
//
//  Created by Logan Doughty on 14/8/2022.
//

import SwiftUI

struct StarRatingView: View {
    @State var rating: Int
    
    var stars = [1, 2, 3, 4, 5]
    
    var body: some View {
        HStack {
            ForEach(stars, id: \.self){ star in
                Image(systemName: "star.fill")
                    .foregroundColor(star <= rating ? Color.yellow : Color.gray)
            }
        }
    }
}

struct StarRatingView_Previews: PreviewProvider {
    static var previews: some View {
        StarRatingView(rating: 2)
    }
}
