//
//  MenuBar.swift
//  BigUpTunes
//
//  Created by Omar Hegazy on 4/22/23.
//
//

import Foundation
import UIKit

protocol MenuBarDelegate: AnyObject {
    func didSelectItemAt(index: Int)
}

class MenuBar: UIView {
    
    let newReleasesButton: UIButton!
    let playlistButton: UIButton!
    let recommendedButton: UIButton!
    var buttons: [UIButton]!
    
    let indicator = UIView()
    
    var indicatorLeading: NSLayoutConstraint?
    var indicatorTrailing: NSLayoutConstraint?

    weak var delegate: MenuBarDelegate?
    
    let leadPadding: CGFloat = 16
    let buttonSpace: CGFloat = 36

    override init(frame: CGRect) {
        newReleasesButton = makeButton(withText: "New Releases")
        playlistButton = makeButton(withText: "Playlist")
        recommendedButton = makeButton(withText: "Recommended")

        buttons = [newReleasesButton, playlistButton, recommendedButton]

        super.init(frame: .zero)
        
        newReleasesButton.addTarget(self, action: #selector(newReleaseButtonTapped), for: .primaryActionTriggered)
        playlistButton.addTarget(self, action: #selector(playlistButtonTapped), for: .primaryActionTriggered)
        recommendedButton.addTarget(self, action: #selector(recommendedTracksButtonTapped), for: .primaryActionTriggered)

        styleIndicator()
        setAlpha(for: newReleasesButton)
        layout()
    }
    
    private func styleIndicator() {
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.backgroundColor = .spotifyBlack
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        addSubview(newReleasesButton)
        addSubview(playlistButton)
        addSubview(recommendedButton)
        addSubview(indicator)

        NSLayoutConstraint.activate([
            // Buttons
            newReleasesButton.topAnchor.constraint(equalTo: topAnchor),
            newReleasesButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leadPadding),
            playlistButton.topAnchor.constraint(equalTo: topAnchor),
            playlistButton.leadingAnchor.constraint(equalTo: newReleasesButton.trailingAnchor, constant: buttonSpace),
            recommendedButton.topAnchor.constraint(equalTo: topAnchor),
            recommendedButton.leadingAnchor.constraint(equalTo: playlistButton.trailingAnchor, constant: buttonSpace),
            
            // bar
            indicator.bottomAnchor.constraint(equalTo: bottomAnchor),
            indicator.heightAnchor.constraint(equalToConstant: 3)

        ])
        
        indicatorLeading = indicator.leadingAnchor.constraint(equalTo: newReleasesButton.leadingAnchor)
        indicatorTrailing = indicator.trailingAnchor.constraint(equalTo: newReleasesButton.trailingAnchor)
        
        indicatorLeading?.isActive = true
        indicatorTrailing?.isActive = true

    }
}

extension MenuBar {
    
    @objc func newReleaseButtonTapped() {
        delegate?.didSelectItemAt(index: 0)
    }
    
    @objc func playlistButtonTapped() {
        delegate?.didSelectItemAt(index: 1)
    }

    @objc func recommendedTracksButtonTapped() {
        delegate?.didSelectItemAt(index: 2)
    }
    
}

extension MenuBar {
    
    func selectItem(at index: Int) {
         animateIndicator(to: index)
    }
    
    private func animateIndicator(to index: Int) {

        var button: UIButton
        switch index {
        case 0:
            button = newReleasesButton
        case 1:
            button = playlistButton
        case 2:
            button = recommendedButton
        default:
            button = newReleasesButton
        }
        
        setAlpha(for: button)
        
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
    
    private func setAlpha(for button: UIButton) {
        newReleasesButton.alpha = 0.5
        playlistButton.alpha = 0.5
        newReleasesButton.alpha = 0.5
        
        button.alpha = 1.0
    }
    
    func scrollIndicator(to contentOffset: CGPoint) {
        let index = Int(contentOffset.x / frame.width)
        let atScrollStart = Int(contentOffset.x) % Int(frame.width) == 0
        
        if atScrollStart {
            return
        }
        
        // determine percent scrolled relative to index
        let percentScrolled: CGFloat
        switch index {
        case 0:
             percentScrolled = contentOffset.x / frame.width - 0
        case 1:
            percentScrolled = contentOffset.x / frame.width - 1
        case 2:
            percentScrolled = contentOffset.x / frame.width - 2
        default:
            percentScrolled = contentOffset.x / frame.width
        }
        
        // determine buttons
        var fromButton: UIButton
        var toButton: UIButton
        
        switch index {
        case 2:
            fromButton = buttons[index]
            toButton = buttons[index - 1]
        default:
            fromButton = buttons[index]
            toButton = buttons[index + 1]
        }
        
        // animate alpha of buttons
        switch index {
        case 2:
            break
        default:
            fromButton.alpha = fmax(0.5, (1 - percentScrolled))
            toButton.alpha = fmax(0.5, percentScrolled)
        }
        
        let fromWidth = fromButton.frame.width
        let toWidth = toButton.frame.width
        
        // determine width
        let sectionWidth: CGFloat
        switch index {
        case 0:
            sectionWidth = leadPadding + fromWidth + buttonSpace
        default:
            sectionWidth = fromWidth + buttonSpace
        }

        // normalize x scroll
        let sectionFraction = sectionWidth / frame.width
        let x = contentOffset.x * sectionFraction
        
        let buttonWidthDiff = fromWidth - toWidth
        let widthOffset = buttonWidthDiff * percentScrolled

        // determine leading y
        let y:CGFloat
        switch index {
        case 0:
            if x < leadPadding {
                y = x
            } else {
                y = x - leadPadding * percentScrolled
            }
        case 1:
            y = x + 13
        case 2:
            y = x
        default:
            y = x
        }
        
        // Note: 13 is button width difference between Playlists and Artists button
        // from previous index. Hard coded for now.
        
        indicatorLeading?.constant = y

        // determine trailing y
        let yTrailing: CGFloat
        switch index {
        case 0:
            yTrailing = y - widthOffset
        case 1:
            yTrailing = y - widthOffset - leadPadding
        case 2:
            yTrailing = y - widthOffset - leadPadding / 2
        default:
            yTrailing = y - widthOffset - leadPadding
        }
        
        indicatorTrailing?.constant = yTrailing
        
        print("\(index) percentScrolled=\(percentScrolled)")
    }
}


func makeButton(withText text: String) -> UIButton {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle(text, for: .normal)
    button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
    button.titleLabel?.adjustsFontSizeToFitWidth = true
    button.setTitleColor(.label, for: .normal)

    return button
}


/*enum Theme: String {
 case light, dark, system

 // Utility var to pass directly to window.overrideUserInterfaceStyle
 var uiInterfaceStyle: UIUserInterfaceStyle {
     switch self {
     case .light:
         return .light
     case .dark:
         return .dark
     case .system:
         return .unspecified
     }
 }
}*/
