//
//  SelectColorView.swift
//  MeDrop
//
//  Created by jose Yun on 2023/07/08.
//

import SwiftUI

struct SelectColorView: View {
    @Environment(\.dismiss) private var dismiss // 직전으로 돌아가기
    @State var profileCard: ProfileCardModel
    @State var colorSelection: Color =  DesignSystemAsset.CardColor.white
    
    var body: some View {
        NavigationView {
            VStack{                
                Image(systemName: "lanyardcard").font(.system(size: 300))
                    .foregroundColor(colorSelection)
                    .shadow(radius: 5)
                
                HStack {
                    Button(action: { colorSelection =  DesignSystemAsset.CardColor.white}) {
                        Circle().foregroundColor(DesignSystemAsset.CardColor.white)
                    }
                    
                    Button(action: { colorSelection =  DesignSystemAsset.CardColor.blue1}) {
                        Circle().foregroundColor(DesignSystemAsset.CardColor.blue1)
                    }
                    
                    Button(action: { colorSelection =  DesignSystemAsset.CardColor.black}) {
                        Circle().foregroundColor(DesignSystemAsset.CardColor.black)
                    }
                    
                    Button(action: {colorSelection =  DesignSystemAsset.CardColor.lime}) {
                        Circle().foregroundColor(DesignSystemAsset.CardColor.lime)
                    }
                    
                    Button(action: { colorSelection =  DesignSystemAsset.CardColor.neonPink}) {
                        Circle().foregroundColor(DesignSystemAsset.CardColor.neonPink)
                    }
                }.shadow(color: .gray, radius: 3)
                    .padding()
            }
        }.navigationTitle("프로필 만들기")
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("돌아가기") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("완료") {
//                        profileCard.card = colorSelection
                        // save model later 
                    }
                }
            } // toolbar end
        
    }
}

struct SelectColorView_Previews: PreviewProvider {
    static var previews: some View {
        SelectColorView(profileCard: ProfileCardModel())
    }
}
