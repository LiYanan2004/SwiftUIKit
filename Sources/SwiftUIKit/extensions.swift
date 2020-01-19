//
//  extensions.swift
//  
//
//  Created by LiYanan2004 on 2020/1/19.
//

import SwiftUI

extension UIImage {

    func addImage(_ image: UIImage) -> UIImage {

        UIGraphicsBeginImageContext(image.size)

        let toImage = self
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        toImage.draw(in: rect)
        image.draw(in: rect)
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()

        UIGraphicsEndImageContext()

        return resultImage!
    }
}

extension UIColor {

    func asImage(_ size: CGSize) -> UIImage {
        var resultImage: UIImage? = nil
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)

        UIGraphicsBeginImageContextWithOptions(rect.size, false, UIScreen.main.scale)

        guard let context = UIGraphicsGetCurrentContext() else {
            return resultImage!
        }

        context.setFillColor(self.cgColor)
        context.fill(rect)
        resultImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return resultImage ?? UIImage()
    }
}
