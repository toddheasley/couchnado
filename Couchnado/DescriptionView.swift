import SwiftUI

struct DescriptionView: View {
    let description: String
    
    init(_ description: String) {
        self.description = description
    }
    
    // MARK: View
    var body: some View {
        Text(description)
            .font(.tableDescription)
            .truncationMode(.tail)
            .lineLimit(1)
            .padding(.vertical, 10.0)
    }
}

struct DescriptionView_Previews: PreviewProvider {
    
    // MARK: PreviewProvider
    static var previews: some View {
        DescriptionView("276 videos")
            .padding()
    }
}
