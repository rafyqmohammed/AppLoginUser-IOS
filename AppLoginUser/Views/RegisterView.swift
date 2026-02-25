//
//  RegisterView.swift
//  AppLoginUser
//
//  Created by tamtam-8 on 25/2/2026.
//

import SwiftUI

struct RegisterView: View {
   
    var body: some View {

//       ZStack {
//            // Arrière-plan AsyncImage avec fallback orange
//            AsyncImage(url: URL(string: "https://placehold.co/200x200/orange/orange.png")) { phase in
//                switch phase {
//                case .success(let image):
//                    image
//                        .resizable()
//                        .scaledToFill()
//                        .ignoresSafeArea()
//                case .failure:
//                    Color.orange
//                        .ignoresSafeArea()
//                case .empty:
//                    Color.orange
//                        .ignoresSafeArea()
//                @unknown default:
//                    Color.orange
//                        .ignoresSafeArea()
//                }
//          
//              }
//           VStack {
//               Text("WELCOME")
//                   .font(.largeTitle)
//                   .bold()
//                   .foregroundColor(.white)
//               
//               VStack{
//                  // champ Username
//                   HStack{
//                       // icone
//                       Image(systemName: "envlope")
//                           .foregroundColor(.gray)
//                       TextField("Username / Email ")
//                           
//                   }
//               }
//               .padding()
//               .background(){
//                   Rectangle()
//                       .foregroundStyle(Color.white)
//                       .clipShape(RoundedRectangle(cornerRadius: 16, style:.continuous))
//                       .shadow(radius: 15)
//                   
//               }
//           }
//           
//        
//           
//           
//          }
        

    
        
    }
}

#Preview {
    NavigationStack {
        RegisterView()
    }
}
