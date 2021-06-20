//
//  FocusIndicatorView.swift
//  TikTok
//
//  Created by Imran on 19/6/21.
//

import UIKit
import Foundation

public class FocusIndicatorView: UIView {

    // MARK: - ivars
    private lazy var _focusRingView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "focus_indicator"))
        return view
    }()

    // MARK: - object lifecycle
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.contentMode = .scaleToFill

        _focusRingView.alpha = 0
        self.addSubview(_focusRingView)

        self.frame = self._focusRingView.frame

        self.prepareAnimation()
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        self._focusRingView.layer.removeAllAnimations()
    }
}

// MARK: - animation
extension FocusIndicatorView {

    private func prepareAnimation() {
        // prepare animation
        self._focusRingView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        self._focusRingView.alpha = 0
    }

    public func startAnimation() {
        self._focusRingView.layer.removeAllAnimations()

        // animate
        UIView.animate(withDuration: 0.2) {
            self._focusRingView.alpha = 1
        }
        UIView.animate(withDuration: 0.5) {
            self._focusRingView.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        }
    }

    public func stopAnimation() {
        self._focusRingView.layer.removeAllAnimations()

        UIView.animate(withDuration: 0.2) {
            self._focusRingView.alpha = 0
        }
        UIView.animate(withDuration: 0.2) {
            self._focusRingView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        } completion: { (completed) in
            if completed {
                self.removeFromSuperview()
            }
        }
    }

}
