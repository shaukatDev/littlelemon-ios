//
//  Home.swift
//  littlelemon
//
//  Created by Ali on 24/10/23.
//

import SwiftUI

struct Home: View {
    
    var body: some View {
    
            VStack{
                TopBar()
                Menu() .tabItem {
                    Label("Menu", systemImage: "list.dash")
            }
        }.navigationBarBackButtonHidden(true)
    }
}

#Preview {
    Home()
}
