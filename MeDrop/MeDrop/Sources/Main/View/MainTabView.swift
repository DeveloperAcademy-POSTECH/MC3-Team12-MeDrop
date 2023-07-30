//
//  MainTabView.swift
//  MeDrop
//
//  Created by jose Yun on 2023/07/30.
//

import SwiftUI

struct MainTabView: View {
        @State private var selectedTab: Tab = .my
        @State private var showingAlert = false
    
        @StateObject private var cardStore = CardStore()
    
    var bottomBar: some View {
        HStack(spacing: 0) {
            Spacer()
            ForEach(tabItems) { tabItem in
                Button(action: {
                    if tabItem.type == .tabType {
                        withAnimation(.easeInOut) {
                            selectedTab = tabItem.tab!
                        }
                    } else {
                        showingAlert = true
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
                        Image(systemName: "plus").foregroundColor(selectedTab == .my ? .black : .gray).padding()
                            .symbolVariant(.fill)
                            .font(.body.bold())
                            .foregroundColor(Color.white)
                            .background(Circle().foregroundColor(.white))
                            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: -1)
                            
                            .disabled(selectedTab == .your)
                            
                        
                    }
                }
                .offset(y: tabItem.type == .tabType ? 0 : -35)
                .foregroundColor(selectedTab == tabItem.tab ? .black : .secondary)
                .frame(maxWidth: .infinity)
                Spacer()
            }
        }
        .frame(height: 88, alignment: .top)
        .padding(.top, 14)
    }
        
        var body: some View {
            NavigationStack {
                VStack {
                    Group {
                        switch selectedTab {
                        case .my:
                            MyCardsView(myCards: $cardStore.myCards) {
                                Task {
                                    try await cardStore.saveData()
                                }
                            }
                        case .your:
                            CollectedCardsView(yourCards: $cardStore.yourCards){
                                Task {
                                    try await cardStore.saveData()
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                    TabClipperShape(radius: 38.0)
                        .fill(Color(.white))
                        .frame(height: 88, alignment: .top)
                        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: -1)
                        .overlay(bottomBar)
                        .alert("교환 버튼 클릭", isPresented: $showingAlert) {
                            Button("확인", role: .cancel) { }
                        }
                }
                .navigationTitle(selectedTab == .my ? "ME Card" : "Collected Cards")
                .navigationBarTitleDisplayMode(.large)
                .background(Color.clear)
                .ignoresSafeArea()
                
            }.task {
                do {
                    try await cardStore.loadData()
                } catch {
                    print("load Error")
                }
            }
        }
    }

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
