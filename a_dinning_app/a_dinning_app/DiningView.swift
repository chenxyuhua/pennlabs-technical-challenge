//
//  ContentView.swift
//  a_dinning_app
//
//  Created by on 2/2/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = DiningViewModel()
    
    struct Place: Decodable, Identifiable, Hashable {
        let id: Int
        let name: String
        let status: String
        let hours: [String]
        let image: String
    }
    
    struct Row: View {
        let place: Place
        
        var body: some View {
            HStack {
                AsyncImage(url: URL(string: place.image)) { image in
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120, height: 80)
                    .cornerRadius(5)
                
                VStack(alignment: .leading) {
                    Text(place.status)
                        .foregroundColor(place.status == "OPEN" ? .blue : .gray)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    

                    Text(place.name)
                        .font(.headline)
                    
//                    Text(place.hours)
//                        .font(.subheadline)
                }
            }
        }
    }
    
//    let diningHalls = [
//        Place(name: "1920 Commons", status: "OPEN", hours: "11 - 3 | 5 - 8", image: "image"),
//        Place(name: "Hill College House", status: "CLOSED", hours: "8", image: "image"),
//        Place(name: "English House", status: "CLOSED", hours: "10 - 2 | 5 - 9", image: "image"),
//        Place(name: "Lauder House", status: "OPEN", hours: "11 - 7", image: "image")
//    ]
//    
//    let retailDinings = [
//        Place(name: "1920 Commons", status: "OPEN", hours: "11 - 3 | 5 - 8", image: "image"),
//        Place(name: "Hill College House", status: "CLOSED", hours: "8", image: "image"),
//        Place(name: "English House", status: "CLOSED", hours: "10 - 2 | 5 - 9", image: "image"),
//        Place(name: "Lauder House", status: "OPEN", hours: "11 - 7", image: "image")
//    ]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("SUNDAY, FEBRUARY 4")
                .font(.system(size: 11, weight: .heavy))
                .foregroundColor(.gray)
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
            
            Text("Dining Halls")
                .font(.system(size: 28, weight: .bold))
                .padding(.bottom, 12)

//            ForEach(diningHalls, id: \.self) { place in
//                Row(place: place)
//            }
            
            List(viewModel.diningVenues) { venue in
                Row(place: venue)
            }
            
            Text("Retail Dining")
                .font(.system(size: 28, weight: .bold))
                .padding(.bottom, 12)
            
//            ForEach(retailDinings, id: \.self) { place in
//                Row(place: place)
//            }

        }
        .padding(.horizontal)
    }
}

#Preview {
    ContentView()
}
