//
//  Button.swift
//  CocoaTouch
//
//  Created by 朱双泉 on 2018/4/13.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit

protocol ButtonInterface {
    func setTitle(_ title: String);
    func setTitleColor(_ titleColor: UIColor);
    func setTitleEdgeInsets(_ edgeInsets: UIEdgeInsets);
    func setImage(_ image: UIImage);
    func setBackgroundImage(_ image: UIImage);
    func setImageEdgeInsets(_ edgeInsets: UIEdgeInsets);
}

class Button: UIControl, ButtonInterface {

    lazy var titleLabel: UILabel =  {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        titleLabel.textAlignment = .center
        return titleLabel
    }()
    lazy var imageView: UIImageView = UIImageView()
    lazy var backgroundImageView: UIImageView = UIImageView()
    
    var titleLabelIsCreated = false
    var imageViewIsCreated = false
    var backgroundImageViewCreated = false
    var createdFromNib = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createdFromNib = true
    }
    
    internal func setTitle(_ text: String) {
        if !titleLabelIsCreated {
            addSubview(titleLabel)
            titleLabelIsCreated = true
        }
        titleLabel.text = text
    }

    internal func setTitleColor(_ textColor: UIColor) {
        if !titleLabelIsCreated {
            return
        }
        titleLabel.textColor = textColor
    }
    
    internal func setTitleEdgeInsets(_ edgeInsets: UIEdgeInsets) {
        if !titleLabelIsCreated {
            return
        }
    }
    
    internal func setImage(_ image: UIImage) {
        if !imageViewIsCreated {
            addSubview(imageView)
            if titleLabelIsCreated {
                insertSubview(imageView, belowSubview: titleLabel)
            }
            imageViewIsCreated = true
        }
        imageView.image = image
    }
    
    internal func setBackgroundImage(_ image: UIImage) {
        if !backgroundImageViewCreated {
            addSubview(backgroundImageView)
            insertSubview(backgroundImageView, at: 0)
            backgroundImageViewCreated = true
        }
        backgroundImageView.image = image
    }
    
    internal func setImageEdgeInsets(_ edgeInsets: UIEdgeInsets) {
        if !imageViewIsCreated {
            return
        }
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return bestSize()
    }
    
    override var intrinsicContentSize: CGSize {
        return bestSize()
    }
    
    func bestSize() -> CGSize {
        if titleLabelIsCreated && !imageViewIsCreated && !backgroundImageViewCreated {
            let text: NSString? = titleLabel.text as NSString?
            let titleLabelW: CGFloat = text?.boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: bounds.height), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font : titleLabel.font], context: nil).size.width ?? 0.0
            let titleLabelH: CGFloat = text?.boundingRect(with: CGSize(width: titleLabelW, height: CGFloat(MAXFLOAT)), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font : titleLabel.font], context: nil).size.height ?? 0.0
            return CGSize(width: titleLabelW, height: titleLabelH + 10)
        } else if !titleLabelIsCreated && imageViewIsCreated {
            return imageView.image?.size ?? CGSize.zero
        } else if titleLabelIsCreated && imageViewIsCreated {
            let text: NSString? = titleLabel.text as NSString?
            let titleLabelW: CGFloat = text?.boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: bounds.height), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font : titleLabel.font], context: nil).size.width ?? 0.0
            let titleLabelH: CGFloat = text?.boundingRect(with: CGSize(width: titleLabelW, height: CGFloat(MAXFLOAT)), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font : titleLabel.font], context: nil).size.height ?? 0.0
            let imageViewW: CGFloat = imageView.image?.size.width ?? 0.0
            let imageViewH: CGFloat = imageView.image?.size.height ?? 0.0
            return CGSize(width: titleLabelW + imageViewW, height: imageViewH > titleLabelH ? imageViewH : titleLabelH)
        } else {
            return backgroundImageView.image?.size ?? CGSize.zero
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        if createdFromNib {
            frame.size = intrinsicContentSize
        }
        
        if titleLabelIsCreated && !imageViewIsCreated {
            titleLabel.frame = bounds
        } else if !titleLabelIsCreated && imageViewIsCreated {
            let y: CGFloat = 0;
            let width: CGFloat = imageView.image?.size.width ?? 0;
            let x: CGFloat = (bounds.width - width) * 0.5;
            let height: CGFloat = bounds.height;
            imageView.frame = CGRect(x: x, y: y, width: width, height: height)
        } else if titleLabelIsCreated && imageViewIsCreated {
            let imageViewY: CGFloat = 0;
            let imageViewW: CGFloat = imageView.image?.size.width ?? 0;
            let imageViewH: CGFloat = bounds.height;
            let text: NSString? = titleLabel.text as NSString?
            let titleLabelW: CGFloat = text?.boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: bounds.height), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font : titleLabel.font], context: nil).size.width ?? 0.0
            let titleLabelH: CGFloat = text?.boundingRect(with: CGSize(width: titleLabelW, height: CGFloat(MAXFLOAT)), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font : titleLabel.font], context: nil).size.height ?? 0.0
            let imageViewX: CGFloat = (bounds.width - imageViewW - titleLabelW) * 0.5;
            let titleLabelX: CGFloat = imageViewX + imageViewW
            let titleLabelY = (bounds.height - titleLabelH) * 0.5
            titleLabel.frame = CGRect(x: titleLabelX, y: titleLabelY, width: titleLabelW, height: titleLabelH)
            imageView.frame = CGRect(x: imageViewX, y: imageViewY, width: imageViewW, height: imageViewH)
        }
        
        if backgroundImageViewCreated {
            backgroundImageView.frame = bounds
        }
    }
}
