import SwiftUI

struct DropdownView: View {
    @State private var selectedOption: String = "Option 1"
    @State var expand = false
    let options = ["Option 1", "Option 2", "Option 3"]

    var body: some View {
        
        //            Menu {
        //                ForEach(options, id: \.self) { option in
        //                    Button(action: {
        //                        self.selectedOption = option
        //                    }) {
        //                        Circle()
        //                            .foregroundColor(.black)
        //                    }
        //                }
        //            } label: {
        //                Label("Select Option", systemImage: "chevron.down.circle")
        //            }
        
        
        
        
        VStack {
            if expand {
                VStack {
                    Circle().frame(width: 50)
                    Circle().frame(width: 50)
                }
                .padding(10)
                    .background(Color.green)
                    .cornerRadius(50)
            }
            Circle().foregroundColor(.blue).frame(width: 50).onTapGesture{
                self.expand.toggle()
            }
            
        }
        .alignmentGuide(VerticalAlignment.center) { $0[.bottom] }
        .animation(.spring())
    }
    
}

struct DropdownView_Previews: PreviewProvider {
    static var previews: some View {
        DropdownView()
    }
}
