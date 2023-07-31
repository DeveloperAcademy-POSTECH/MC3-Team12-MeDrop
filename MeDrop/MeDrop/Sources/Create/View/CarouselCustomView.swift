//
//  CarouselCustomView.swift
//  MeDrop
//
//  Created by jose Yun on 2023/07/31.
//

import SwiftUI


struct CarouselCustomView_Previews: PreviewProvider {
    static var previews: some View {
        CarouselCustomView()
    }
}
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
        for index in 0...7 {
            let new = Item(id: index, title: "Item \(index)", color: colors[index])
            items.append(new)
        }
    }
}

struct CarouselCustomView: View {
    
    @StateObject var store = Store()
    @State var snappedItem = 0.0
    @State var draggingItem = 0.0
    @State var activeIndex: Int = 0
    
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
//                    .opacity(myXOffset(item.id) < 240 && myXOffset(item.id) > -240 ? 1.0 : 0.0)
//                    .opacity(distance(item.id) >= 0 ? 1.0 : 0.0)
                    .offset(x: myXOffset(item.id), y: 0)
                    .zIndex(1.0 - abs(distance(item.id)) * 0.1)
                }
        }
        .gesture(
            DragGesture()
                .onChanged { value in
                    draggingItem = snappedItem - value.translation.width / 400
                }
                .onEnded { value in
                    withAnimation {
                        draggingItem = snappedItem - value.predictedEndTranslation.width / 400
                        draggingItem = round(draggingItem).remainder(dividingBy: Double(store.items.count))
                        snappedItem = draggingItem
                        
                        //Get the active Item index
                        self.activeIndex = store.items.count + Int(draggingItem)
                        if self.activeIndex > store.items.count || Int(draggingItem) >= 0 {
                            self.activeIndex = Int(draggingItem)
                        }
                        print(self.activeIndex)
                    }
                    
                }
        )
    }
    
    func distance(_ item: Int) -> Double {

        return (draggingItem - Double(item))
//            .remainder(dividingBy: Double(store.items.count))
    }

    func myXOffset(_ item: Int) -> Double {
//        let angle = Double.pi * 2 / Double(store.items.count) * distance(item) * 300
        let angle = -(distance(item)) * 300
        print("item ID \(item), angle \(angle)")
        return Double(angle)
    }
}
