import SwiftUI

struct FilterButton: View {
    
    // MARK: View
    var body: some View {
        Button(action: {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }) {
            Image(systemName: "sidebar.leading")
                .font(.title2)
        }
    }
}

struct FilterButton_Previews: PreviewProvider {
    
    // MARK: PreviewProvider
    static var previews: some View {
        FilterButton()
    }
}
