import SwiftUI

struct DescriptionView: View {
    let description: String
    
    // MARK: View
    var body: some View {
        Text(description)
            .truncationMode(.tail)
            .lineLimit(1)
    }
}

struct DescriptionView_Previews: PreviewProvider {
    
    // MARK: PreviewProvider
    static var previews: some View {
        DescriptionView(description: "276 videos")
            .padding()
    }
}
