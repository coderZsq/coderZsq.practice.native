//
//  TitleView.swift
//  LiveBroadcast
//
//  Created by 朱双泉 on 2018/12/10.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit

protocol TitleViewDelegate: class {
    func titleView(_ titleView: TitleView, targetIndex: Int)
}

class TitleView: UIView {

    weak var delegate: TitleViewDelegate?
    
    fileprivate var titles: [String]
    fileprivate var style: TitleStyle
    fileprivate lazy var currentIndex = 0
    fileprivate lazy var titleLabels = [UILabel]()
    fileprivate lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: self.bounds)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.contentInsetAdjustmentBehavior = .never
        return scrollView
    }()
    fileprivate lazy var bottomLine: UIView = {
        let bottomLine = UIView()
        bottomLine.backgroundColor = self.style.scrollLineColor
        bottomLine.frame.size.height = self.style.scrollLineHeight
        bottomLine.frame.origin.y = self.bounds.height - self.style.scrollLineHeight
        return bottomLine
    }()
    
    init(frame: CGRect, titles: [String], style: TitleStyle = TitleStyle()) {
        self.titles = titles
        self.style = style
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TitleView {
    
    fileprivate func setupUI() {
        addSubview(scrollView)
        setupTitleLabels()
        setupTitleLabelsFrame()
        scrollView.addSubview(bottomLine)
        if style.isShowScrollLine {
            scrollView.addSubview(bottomLine)
        }
    }
    
    private func setupTitleLabels() {
        for (i, title) in titles.enumerated() {
            let titleLabel = UILabel()
            titleLabel.text = title
            titleLabel.textColor = style.normalColor
            titleLabel.font = UIFont.systemFont(ofSize: style.fontSize)
            titleLabel.tag = i
            titleLabel.textAlignment = .center
            titleLabel.textColor = i == 0 ? style.selectColor : style.normalColor
            scrollView.addSubview(titleLabel)
            titleLabels.append(titleLabel)
            titleLabel.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(titleLabelClick(_:)))
            titleLabel.addGestureRecognizer(tapGes)
        }
    }
    
    private func setupTitleLabelsFrame() {
        let count = titles.count
        for (i, label) in titleLabels.enumerated() {
            var w: CGFloat = 0
            let h: CGFloat = bounds.height
            var x: CGFloat = 0
            let y: CGFloat = 0
            if style.isScrollEnable {
                w = (titles[i] as NSString).boundingRect(with: CGSize(width: Double.infinity, height: 0), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : label.font], context: nil).width
                if i == 0 {
                    x = style.itemMargin * 0.5
                    if style.isShowScrollLine {
                        bottomLine.frame.origin.x = x
                        bottomLine.frame.size.width = w
                    }
                } else {
                    x = titleLabels[i - 1].frame.maxX + style.itemMargin
                }
            } else {
                w = bounds.width / CGFloat(count)
                x = w * CGFloat(i)
                if i == 0 && style.isShowScrollLine {
                    bottomLine.frame.origin.x = 0
                    bottomLine.frame.size.width = w
                }
            }
            label.frame = CGRect(x: x, y: y, width: w, height: h)
        }
        scrollView.contentSize = style.isScrollEnable ?
            CGSize(width: titleLabels.last!.frame.maxX + style.itemMargin * 0.5, height: 0) :
            .zero
    }
}

extension TitleView {
    @objc fileprivate func titleLabelClick(_ tapGes: UITapGestureRecognizer) {
        let targetLabel = tapGes.view as! UILabel
        adjustTitleLabel(targetIndex: targetLabel.tag)
        UIView.animate(withDuration: 0.25) {
            self.bottomLine.frame.origin.x = targetLabel.frame.origin.x
            self.bottomLine.frame.size.width = targetLabel.frame.width
        }
        delegate?.titleView(self, targetIndex: currentIndex)
    }
    
    fileprivate func adjustTitleLabel(targetIndex: Int) {
        if targetIndex == currentIndex { return }
        let targetLabel = titleLabels[targetIndex]
        let sourceLabel = titleLabels[currentIndex]
        sourceLabel.textColor = style.normalColor
        targetLabel.textColor = style.selectColor
        currentIndex = targetIndex
        if style.isScrollEnable {
            var offsetX = targetLabel.center.x - scrollView.bounds.width * 0.5
            if offsetX < 0 {
                offsetX = 0
            }
            if offsetX > (scrollView.contentSize.width - scrollView.bounds.width) {
                offsetX = scrollView.contentSize.width - scrollView.bounds.width
            }
            scrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
        }
    }
}

extension TitleView: ContentViewDelegate {
    
    func contentView(_ contentView: ContentView, targetIndex: Int) {
        adjustTitleLabel(targetIndex: targetIndex)
    }
    
    func contentView(_ contentView: ContentView, targetIndex: Int, progress: CGFloat) {
        let targetLabel = titleLabels[targetIndex]
        let sourceLabel = titleLabels[currentIndex]
        let deltaRGB = UIColor.getRGBDelta(style.selectColor, style.normalColor)
        let selectRGB = style.selectColor.getRGB()
        let normalRGB = style.normalColor.getRGB()
        targetLabel.textColor = UIColor(
            r: normalRGB.0 + deltaRGB.0 * progress,
            g: normalRGB.1 + deltaRGB.1 * progress,
            b: normalRGB.2 + deltaRGB.2 * progress
        )
        sourceLabel.textColor = UIColor(
            r: selectRGB.0 - deltaRGB.0 * progress,
            g: selectRGB.1 - deltaRGB.1 * progress,
            b: selectRGB.2 - deltaRGB.2 * progress
        )
        if style.isShowScrollLine {
            let deltaX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
            let deltaW = targetLabel.frame.width - sourceLabel.frame.width
            bottomLine.frame.origin.x = sourceLabel.frame.origin.x + deltaX * progress
            bottomLine.frame.size.width = sourceLabel.frame.width + deltaW * progress
        }
    }
    
}
