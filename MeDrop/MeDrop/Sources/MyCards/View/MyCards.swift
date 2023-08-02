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
    
//    @Binding var myCards: [ProfileCardModel]
    @State var myCards = PreferenceManager.myCards!
    @State private var newCard = ProfileCardModel.emptyCard
    @Binding var selectedIndex: Int
    
    @Environment(\.scenePhase) private var scenePhase
    
    @State var isMenu = false
    @State var isDetail = false
    @State var isCreate = false
    @State var expand = false
    
    @State var showingAlert = false
    @State var showingInvalidAlert = false
    
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
                                        expand.toggle()
                                    }, label: {
                                        Image("ExportButton")
                                            .resizable()
                                            .frame(width: UIScreen.width * 0.15, height: UIScreen.width * 0.15)
                                            .scaledToFit()
                                            .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 2)
                                    })
                                    .offset(y: expand ?  -UIScreen.height * 0.16 : 0)
                                
                        Button(action: {
                            
                            print(selectedIndex)
                            print(PreferenceManager.myCards!.count)
                            
                        
                            
                            if selectedIndex >= 0 && selectedIndex < myCards.count {
                                selectedTab = .exchange
                            } else {
                                showingInvalidAlert.toggle()
                            }
                            expand.toggle()
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
            }.frame(height: UIScreen.height * 0.1, alignment: .top)
            .alert(isPresented: $showingInvalidAlert) {
                Alert(title: Text(myCards.isEmpty ? "아직 교환할 명함이 없어요!" : "유효하지 않은 명함입니다."), message: Text(myCards.isEmpty ? "먼저 명함을 만들어주세요.": "내 명함 화면에서 명함을 선택해주세요."), dismissButton: .default(Text("확인")))
            }.onDisappear {
                expand = false
            }
        
        }

    var body: some View {
        NavigationStack {
            VStack {
                CustomCarouselView(activeIndex: $selectedIndex, cards: $myCards)
                Spacer()
                TabClipperShape(radius: 38.0)
                    .fill(Color(.white))
                    .frame(height: UIScreen.height * 0.1, alignment: .top)
                    .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: -1)
                    .overlay(bottomBar)
            }
            .edgesIgnoringSafeArea(.bottom)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationTitle("내 명함")
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
        .onAppear {
            selectedIndex = 0
        }
        .onChange(of: scenePhase) { phase in
            if phase == .inactive { saveAction() }
        }
        .tint(.black)
    }
}
struct MyCardsView_Previews: PreviewProvider {
    static var previews: some View {
        MyCardsView(selectedTab: .constant(Tab.my), selectedIndex: .constant(0), saveAction: {})
    }
}
