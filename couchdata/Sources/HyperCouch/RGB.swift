import Foundation
import CoreGraphics

struct RGB: CustomStringConvertible {
    typealias Pair = (light: Self, dark: Self)
    
    static let alternate: Pair = (Self(203, 229, 209, 0.9), Self(45, 51, 55, 0.75))
    static let background: Pair = (.white, Self(35, 41, 45))
    static let color: Pair = (Self(37, 37, 37, 0.9), Self(221, 221, 221))
    static let link: Pair = (Self(0, 0, 238, 0.9), .color.dark)
    
    static let white: Self = Self(255, 255, 255)
    
    let red: CGFloat
    let green: CGFloat
    let blue: CGFloat
    let alpha: CGFloat
    
    init(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat = 1.0) {
        self.red = red.clamped(0.0...1.0)
        self.green = green.clamped(0.0...1.0)
        self.blue = blue.clamped(0.0...1.0)
        self.alpha = alpha.clamped(0.0...1.0)
    }
    
    init(_ red: Int, _ green: Int, _ blue: Int, _ alpha: CGFloat = 1.0) {
        self.red = CGFloat(red).clamped(0.0...255.0).value
        self.green = CGFloat(green).clamped(0.0...255.0).value
        self.blue = CGFloat(blue).clamped(0.0...255.0).value
        self.alpha = alpha.clamped(0.0...1.0)
    }
    
    // MARK: CustomStringConvertible
    var description: String {
        let description: String = "\(red.intValue), \(green.intValue), \(blue.intValue)"
        guard alpha < 1.0 else {
            return "rgb(\(description))"
        }
        return "rgba(\(description), \(alpha))"
    }
}

private extension CGFloat {
    var intValue: Int { Int(self * 255.0) }
    
    var value: Self { self / 255.0 }
    
    func clamped(_ range: ClosedRange<Self>) -> Self {
        Self.minimum(Self.maximum(self, range.lowerBound), range.upperBound)
    }
}
