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
    @State var expand = false
    
    @State var showingAlert = false
    
    let saveAction: () -> Void
     
    var bottomBar: some View {
        HStack(alignment: .bottom, spacing: 0) {
            Spacer()
            ForEach(tabItems) { tabItem in
                if tabItem.type == .tabType {
                    Button(action: {
                        withAnimation(.easeInOut) {
                            selectedTab = tabItem.tab!
                        } }) {
                        VStack(spacing: 0) {
                            Image(systemName: tabItem.icon)
                                .symbolVariant(.fill)
                                .font(.body.bold())
                            Text(tabItem.text)
                                .font(Font.custom("SF Pro Text", size: 11))
                        }.foregroundColor(selectedTab == tabItem.tab ? .black : .secondary)} }
                else {
                    ZStack {
                                    Button(action: {
                                        print("export")
                                    }, label: {
                                        Image("ExportButton")
                                            .resizable()
                                            .frame(width: UIScreen.width * 0.15, height: UIScreen.width * 0.15)
                                            .scaledToFit()
                                            .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 2)
                                    })
                                    .offset(y: expand ?  -UIScreen.height * 0.16 : 0)
                                
                                    Button(action: {
                                        selectedTab = .exchange
                                    }, label: {
                                        Image("ExchangeButton")
                                            .resizable()
                                            .frame(width: UIScreen.width * 0.15, height: UIScreen.width * 0.15)
                                            .scaledToFit()
                                            .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 2)
                                    })
                                    .offset(y: expand ? -UIScreen.height * 0.08 : 0)
                                
                                    Button(action: {
                                        expand.toggle()
                                    }, label: {
                                        Image("ExchangeMenu")
                                            .resizable()
                                            .frame(width: UIScreen.width * 0.15, height: UIScreen.width * 0.15)
                                            .scaledToFit()
                                            .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 2)
                                    })
                        }
                        .offset(y: -UIScreen.height * 0.05)
                        .animation(.spring())
                    }
                }
                .frame(maxWidth: .infinity)
                Spacer()
            }        .frame(height: UIScreen.height * 0.1, alignment: .top)
        }

    var body: some View {
        NavigationStack {
            VStack {
                CustomCarouselView(activeIndex: .constant(0), cards: $myCards)
                Spacer()
                TabClipperShape(radius: 38.0)
                    .fill(Color(.white))
                    .frame(height: UIScreen.height * 0.1, alignment: .top)
                    .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: -1)
                    .overlay(bottomBar)
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
                CreateCardView(editingCard: $makingCard, originCard: $makingCard, cards: $myCards, isCreate: true)
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
