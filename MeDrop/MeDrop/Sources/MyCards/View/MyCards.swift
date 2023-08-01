//
//  MyCardsView.swift
//  MeDrop
//
//  Created by SY AN on 2023/07/22.
//

import SwiftUI

struct MyCardsView: View {
    
    @Binding var selectedTab: Tab
    @State var makingCard: ProfileCardModel = ProfileCardModel()
    
    @Binding var myCards: [ProfileCardModel]
    @State private var newCard = ProfileCardModel.emptyCard
    @State var selectedIndex = 0
    
    @Environment(\.scenePhase) private var scenePhase
    
    @State var isMenu = false
    @State var isDetail = false
    @State var isCreate = false
    
    @State var showingAlert = false
    
    let saveAction: () -> Void
     
    var bottomBar: some View {
        HStack(spacing: 0) {
            Spacer()
            ForEach(tabItems) { tabItem in
                Button(action: {
                        withAnimation(.easeInOut) {
                            selectedTab = tabItem.tab!
                    }
                }) {
                    if tabItem.type == .tabType {
                        VStack(spacing: 0) {
                            Image(systemName: tabItem.icon)
                                .symbolVariant(.fill)
                                .font(.body.bold())
                            Text(tabItem.text)
                                .font(.caption2)
                                .lineLimit(1)
                        }
                    } else {
                        Image(systemName: tabItem.icon).foregroundColor(selectedTab == .my ? .black : .gray).padding()
                            .symbolVariant(.fill)
                            .font(.body.bold())
                            .foregroundColor(Color.white)
                            .background(Circle().foregroundColor(.white))
                            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: -1)
                            
                            .disabled(selectedTab == .your)
                    }
                }
                .offset(y: tabItem.type == .tabType ? 0 : -UIScreen.height * 0.04)
                .foregroundColor(selectedTab == tabItem.tab ? .black : .secondary)
                .frame(maxWidth: .infinity)
                Spacer()
            }
        }
        .frame(height: UIScreen.height * 0.1, alignment: .top)
        .padding(.top, UIScreen.height * 0.02)
    }

    var body: some View {
        NavigationStack {
            VStack {
                TabView(selection: $selectedIndex) {
                    ForEach($myCards.indices, id: \.self) { index in
                        Button(action: {isDetail.toggle()
                        }) {
                            CardView(card: $myCards[index])
                        }
                        .padding()
                        .tag(index)
                        .navigationDestination(isPresented: $isDetail) {
                            CardDetailMyView(card: $myCards[index], cards: $myCards)
                        }
                    }
                    
                    if $myCards.count == 5 {
                        FinalCardView()
                            .tag($myCards.count + 1)
                            .padding()
                        
                    } else {
                        Button(action: {isCreate.toggle()}) {
                            PlusCardView()
                        }
                        .padding()
                        .tag($myCards.count + 1)
                    }
                }
                .tabViewStyle(PageTabViewStyle())
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                
                TabClipperShape(radius: 38.0)
                        .fill(Color(.white))
                        .frame(height: UIScreen.height * 0.1, alignment: .top)
                        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: -1)
                        .overlay(bottomBar)
                Spacer()
                
            }
            .edgesIgnoringSafeArea(.bottom)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationTitle("ME Card")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                Button(action: { isMenu.toggle() }) {
                    Image(systemName: "gearshape.fill")
                }
                .navigationDestination(isPresented: $isMenu) {
                    MenuView()
                }
            }
            .navigationDestination(isPresented: $isCreate) {
                CreateCardView(editingCard: $makingCard, originCard: $makingCard , cards: $myCards, isCreate: true)
            }
        }
        .onChange(of: scenePhase) { phase in
            if phase == .inactive { saveAction() }
        }
        .tint(.black)
    }
}

struct MyCardsView_Previews: PreviewProvider {
    static var previews: some View {
        MyCardsView(selectedTab: .constant(Tab.my), myCards: .constant(ProfileCardModel.sampleData), saveAction: {})
    }
}
