//
//  MenuDetail.swift
//  littlelemon
//
//  Created by Ali on 24/10/23.
//

import SwiftUI

struct MenuDetail: View {
    let dish:Dish
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var btnBack : some View { Button(action: {
            self.presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                Image(systemName: "chevron.left") // set image here
                        .aspectRatio(contentMode: .fit).frame(width: 40, height: 40)
                    .foregroundColor(.white).background(Color.primaryColorVariant1) .clipShape(Circle())
                }
            }
        }
    var body: some View {
        ScrollView {
            AsyncImage(url: URL(string: dish.image ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
            }
            .clipShape(Rectangle())
            .frame(minHeight: 150)
            VStack(alignment: .leading)
            {
                Text(dish.title ?? "")
                    .font(.subTitleFont())
                    .foregroundColor(.primaryColorVariant1)
                Spacer(minLength: 20)
                Text(dish.itemDesc ?? "")
                    .font(.regularText())
                Spacer(minLength: 10)
                Text("Price: $" + (dish.price ?? ""))
                    .font(.highlightText())
                    .foregroundColor(.primaryColorVariant1)
                    .monospaced()
                Spacer()
            }
        }
        .frame(maxWidth: .infinity)   .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: btnBack)
    }
}


#Preview {
    MenuDetail(dish: PersistenceController.mockDish())
}

