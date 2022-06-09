//
//  UIApplication.swift
//  content_share
//
//  Created by Suraj Maurya on 09/06/22.
//

import Foundation

extension UIApplication {
    func topMostViewController() -> UIViewController? {
        return self.keyWindow?.rootViewController?.topMostViewController()
    }
}

