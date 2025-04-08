import SwiftUI

// Speech Bubble shape for the modal that shows clinic details to user 

struct SpeechBubble: Shape {
    var cornerRadius: CGFloat = 10
    var arrowWidth: CGFloat = 20
    var arrowHeight: CGFloat = 10
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let roundedRect = CGRect(x: rect.origin.x, y: rect.origin.y + arrowHeight, width: rect.size.width, height: rect.size.height - arrowHeight)
        path.addRoundedRect(in: roundedRect, cornerSize: CGSize(width: cornerRadius, height: cornerRadius))
        
        path.move(to: CGPoint(x: rect.midX - arrowWidth / 2, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY + arrowHeight))
        path.addLine(to: CGPoint(x: rect.midX + arrowWidth / 2, y: rect.maxY))
        
        return path
    }
}
