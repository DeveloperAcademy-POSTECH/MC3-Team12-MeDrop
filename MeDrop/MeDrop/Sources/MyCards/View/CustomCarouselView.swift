//
//  CustomCarouselView.swift
//  MeDrop
//
//  Created by jose Yun on 2023/08/01.
//

import SwiftUI

struct Item: Identifiable {
    var id: Int
    var title: String
    var color: Color
}

class Store: ObservableObject {
    @Published var items: [Item]
    
    let colors: [Color] = [.red, .orange, .blue, .teal, .mint, .green, .gray, .indigo, .black]
    
    // dummy data
    init() {
        items = []
        for index in 0..<5 {
            let new = Item(id: index, title: "Item \(index)", color: colors[index])
            items.append(new)
        }
    }
}

struct CustomCarouselView: View {
    
    @StateObject var store = Store()
    @State private var snappedItem = 0.0
    @State private var draggingItem = 0.0
    @Binding var activeIndex: Int
    
    var body: some View {
        
        ZStack {
            ForEach(store.items) { item in
                
                // article view
                ZStack {
                    RoundedRectangle(cornerRadius: 18)
                        .fill(item.color)
                    Text(item.title)
                        .padding()
                }
                .frame(width: 300, height: 300)
                
                .scaleEffect(1.0 - abs(distance(item.id)) * 0.2 )
//                .opacity(1.0 - abs(distance(item.id)) * 0.3 )
                .offset(x: myXOffset(item.id), y: 0)
                .zIndex(1.0 - abs(distance(item.id)) * 0.1)
            }
        }
        .gesture(
            DragGesture()
                .onChanged { value in
                    if value.translation.width < 0 {
                        draggingItem = draggingItem - snappedItem > 1.0 ? snappedItem + 1.0 : snappedItem - value.translation.width / 150
                    } else {
                        draggingItem = snappedItem - draggingItem > 1.0 ? snappedItem - 1.0 : snappedItem - value.translation.width / 150
                    }   
                }
                .onEnded { value in
                    withAnimation {
                        
                        draggingItem = round(draggingItem)
                        
                        print("dragging", draggingItem)
                        print("snapped", snappedItem)
                        
                        //Get the active Item index
                        
                        
                        if Int(self.draggingItem) >= store.items.count {
                            draggingItem = Double(store.items.count - 1)
                        } else if self.draggingItem < 0 {
                            self.activeIndex = 0
                            draggingItem = Double(0.0)
                        }
                        
                        snappedItem = draggingItem
                        self.activeIndex = Int(draggingItem)
                        print("activeIndex", activeIndex)
                    }
                }
        )
    }
    
    func distance(_ item: Int) -> Double {
        return -(draggingItem - Double(item))
    }
    
    func myXOffset(_ item: Int) -> Double {
        let angle =  distance(item)
//        print(item, angle)
        return (angle) * 290
    }
}
struct CustomCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        CustomCarouselView(activeIndex: .constant(0))
    }
}
