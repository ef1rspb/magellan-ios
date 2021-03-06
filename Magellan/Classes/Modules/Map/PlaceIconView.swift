//
/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import UIKit

final class PlaceIconView: UIView, Selectable {
    
    private struct Constants {
        static let size: CGSize = CGSize(width: 48, height: 60)
        static let anchorSize: CGFloat = 6
        static let imageSize: CGFloat = 32
        static let backgroundColor: UIColor = UIColor(red: 0.816, green: 0.008, blue: 0.107, alpha: 1)
    }
    
    private let imageView = UIImageView()
    private let anchorView = UIView()
    private let image: UIImage
    
    init(image: UIImage) {
        self.image = image
        super.init(frame: CGRect(origin: CGPoint.zero, size: Constants.size))
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        let size = Constants.size
        anchorView.frame = CGRect(x: size.width / 2 - Constants.anchorSize / 2 ,
                                  y: size.height / 2 - Constants.anchorSize / 2 + 14,
                                  width: Constants.anchorSize,
                                  height: Constants.anchorSize)
        anchorView.backgroundColor = Constants.backgroundColor
        anchorView.layer.cornerRadius = Constants.anchorSize / 2
        anchorView.layer.borderWidth = 2
        anchorView.layer.borderColor = UIColor.white.cgColor
        addSubview(anchorView)
        
        imageView.frame = CGRect(x: size.width / 2 - Constants.imageSize / 2,
                                 y: size.height / 2 - Constants.imageSize / 2 + 14,
                                 width: Constants.imageSize,
                                 height: Constants.imageSize)
        imageView.backgroundColor = Constants.backgroundColor
        imageView.layer.cornerRadius = Constants.imageSize / 2
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.tintColor = .white
        imageView.image = image
        imageView.contentMode = .center

        addSubview(imageView)
    }
    
    func setSelected(_ selected: Bool, animated: Bool) {
        let imageTransform = selected
            ? CGAffineTransform.identity.scaledBy(x: 1.5, y: 1.5).translatedBy(x: 0, y: -12)
            : CGAffineTransform.identity
        let anchorTransform = selected
            ? CGAffineTransform.identity.translatedBy(x: 0, y: 12)
            : CGAffineTransform.identity
        
        if animated {
            UIView.animate(withDuration: CATransaction.animationDuration()) {
                self.imageView.transform = imageTransform
                self.anchorView.transform = anchorTransform
            }
        } else {
            self.imageView.transform = imageTransform
            self.anchorView.transform = anchorTransform
        }
    }
    
}
