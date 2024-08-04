import Testing
@testable import HyperCouch

struct RGBTests {
    @Test func cgFloatInit() {
        let rgb: RGB = RGB(0.5, 255.0, -1.0, 0.75)
        #expect(rgb.red == 0.5)
        #expect(rgb.green == 1.0)
        #expect(rgb.blue == 0.0)
        #expect(rgb.alpha == 0.75)
    }
    
    @Test func intInit() {
        var rgb: RGB = RGB(127, 1000, -37, 0.75)
        #expect(rgb.red ==  0.4980392156862745)
        #expect(rgb.green == 1.0)
        #expect(rgb.blue == 0.0)
        #expect(rgb.alpha == 0.75)
        rgb = RGB(203, 229, 209)
        #expect(rgb.red == 0.796078431372549)
        #expect(rgb.green == 0.8980392156862745)
        #expect(rgb.blue == 0.8196078431372549)
        #expect(rgb.alpha == 1.0)
    }
    
    // MARK: CustomStringConvertible
    @Test func description() {
        #expect(RGB(0.5, 1.0, 0.0, 0.75).description == "rgba(127, 255, 0, 0.75)")
        #expect(RGB(203, 229, 209).description == "rgb(203, 229, 209)")
    }
}
