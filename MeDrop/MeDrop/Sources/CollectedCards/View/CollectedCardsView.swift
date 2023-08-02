//
//  CollectedCardsView.swift
//  MeDrop
//
//  Created by SY AN on 2023/07/24.
//

import SwiftUI

struct CollectedCardsView: View {
    @Binding var selectedTab: Tab
    
    @State var sortedBy = "이름 순서"
    @State var selectedProfile: ProfileCardModel = ProfileCardModel.sampleData[0]
    @State var container = PreferenceManager.collections!
    @State var isDetail: Bool = false
    @Environment(\.scenePhase) private var scenePhase

    @State var showingAlert = false
    
    let saveAction: () -> Void
    
    func sortingButton(order: String) -> some View {
        Button {
            self.sortedBy = order
        } label: {
            Text(order).font(.caption2)
            Spacer()
            if sortedBy == order {
                Image(systemName: "checkmark.circle.fill")
            } else {
                Image(systemName: "checkmark.circle")
            }
        }
    }
    
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
                        Image("ExchangeMenu")
                            .resizable()
                            .frame(width: UIScreen.width * 0.15, height: UIScreen.width * 0.15)
                            .scaledToFit()
                            .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 2)
                        .opacity(0)
                    }
                        .offset(y: -UIScreen.height * 0.05)
                        .animation(.spring())
                    }
                }
                .frame(maxWidth: .infinity)
                Spacer()
            }        .frame(height: UIScreen.height * 0.1, alignment: .top)
        }
    
    var sortingButton: some View {
        HStack {
        Spacer()
        Menu { sortingButton(order: "이름 순서")
            sortingButton(order: "새로운 순서")
            sortingButton(order: "오래된 순서")
        } label: {
            HStack {
                Text(sortedBy)
                Image(systemName: "chevron.down").foregroundColor(.red)
            }.onChange(of: sortedBy) { _ in
                if sortedBy == "이름 순서" {
                    container.sort {
                        $0.name < $1.name
                    }
                } else if sortedBy == "새로운 순서" {
                    container.sort {
                        $0.date < $1.date
                    }
                } else {
                    container.sort {
                        $0.date > $1.date
                    }
                }
            }
        }.padding(.trailing)
        .foregroundColor(.black)
    }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                DesignSystemAsset.gray4
                    .edgesIgnoringSafeArea(.all)
                VStack(alignment: .leading ) {
                    sortingButton
                    Spacer()
                    
                    if container.isEmpty == false {
                        ScrollView {
                            ForEach(container, id:\.self) { profile in
                                Button(action: {
                                    selectedProfile = profile
                                    isDetail.toggle()
                                },
                                       label: { CollectedCardComponent(yourCards: $container, profileCard: profile).padding(.horizontal)
                                }
                                ).buttonStyle(.plain)
                                .navigationDestination(isPresented: $isDetail) {
                                    CardDetailCollectedView(card: $selectedProfile, cards: $container)
                                }
                            }
                        }
                    }
                    
                    Spacer()
                    
                    TabCollectionShape(radius: 38.0)
                        .fill(.white)
                        .frame(height: UIScreen.height * 0.1, alignment: .top)
                        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: -1)
                        .overlay(bottomBar)
                }
                .edgesIgnoringSafeArea(.bottom)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .navigationTitle("명함 지갑")
            .navigationBarTitleDisplayMode(.inline)
            .onChange(of: scenePhase) { phase in
                if phase == .inactive { saveAction() }
            }
        }
        .tint(.black)
    }
}

struct CollectedCardsView_Previews: PreviewProvider {
    static var previews: some View {
        CollectedCardsView(selectedTab: .constant(Tab.your), container: ProfileCardModel.sampleData, saveAction: {})
    }
}
