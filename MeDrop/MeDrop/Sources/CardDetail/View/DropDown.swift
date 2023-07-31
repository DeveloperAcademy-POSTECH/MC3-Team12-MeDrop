import SwiftUI

struct DropdownView: View {
    @State private var selectedOption: String = "Option 1"
    @State var expand = false
    let options = ["Option 1", "Option 2", "Option 3"]

    var body: some View {
        VStack{
            Circle()
                .foregroundColor(Color.blue)
                .frame(width: 100, height: 100)
                .shadow(color: Color(#colorLiteral(red: 0.051, green: 0.153, blue: 0.314, alpha: 1)).opacity(0.16), radius: 50, x: 28, y: 28)
                .shadow(color: Color.white.opacity(1), radius: 48, x: -23, y: -23)
        }
    }
}

struct DropdownView_Previews: PreviewProvider {
    static var previews: some View {
        DropdownView()
    }
}
