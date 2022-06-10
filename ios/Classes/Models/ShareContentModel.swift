//
//  ShareContentModel.swift
//  content_share
//
//  Created by Suraj Maurya on 09/06/22.
//

import Foundation

struct ShareContentModel: Codable {
    var title: String?
    var text: String?
    var chooserTitle: String?
    var filePath: String?
    var fileType: String?
}
