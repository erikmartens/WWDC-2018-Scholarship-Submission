import UIKit

extension NSMutableParagraphStyle {
    
    convenience init(alignment: NSTextAlignment = .left,
                     lineHeightMultiple: CGFloat = 1,
                     minimumLineHeight: CGFloat = 0,
                     maximumLineHeight: CGFloat = 0,
                     lineSpacing: CGFloat = 5,
                     paragraphSpacingBefore: CGFloat = 5,
                     paragraphSpacing: CGFloat = 5)
    {
        self.init()
        self.alignment = alignment
        self.lineHeightMultiple = lineHeightMultiple
        self.minimumLineHeight = minimumLineHeight
        self.maximumLineHeight = maximumLineHeight
        self.lineSpacing = lineSpacing
        self.paragraphSpacingBefore = paragraphSpacingBefore
        self.paragraphSpacing = paragraphSpacing
    }
}
