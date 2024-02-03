//
//  ContentView.swift
//  a_dinning_app
//
//  Created by 陈昱桦 on 2/2/24.
//

import SwiftUI

struct ContentView: View {
    struct DiningHall {
        let name: String
        let status: String
        let hours: String
        let image: String
    }
    
    let diningHalls = [
        DiningHall(name: "1920 Commons", status: "OPEN", hours: "11 - 3 | 5 - 8", image: "commons")
    
    ]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("SUNDAY, FEBRUARY 4")
                .font(.system(size: 11, weight: .heavy))
                .foregroundColor(.gray)
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
            
            Text("Dining Halls")
                .font(.system(size: 28, weight: .bold))
                .padding(.bottom, 12)

            List {
                
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    ContentView()
}
