//
//  Models.swift
//  KindleX
//
//  Created by Valeriy Fomin on 15/2/22.
//

import UIKit

class Book {
    let title: String
    let author: String
    let image: UIImage
    let pages: [Page]
    let coverImageUrl: String

    init(dictionary: [String: Any]) {
        self.title = dictionary["title"] as? String ?? ""
        self.author = dictionary["author"] as? String ?? ""
        self.image = dictionary["image"] as? UIImage ?? UIImage(named: "bill")!
        self.coverImageUrl = dictionary["coverImageUrl"] as? String ?? ""
        
        var bookPages = [Page]()
        
        if let pagesDictionaries = dictionary["pages"] as? [[String: Any]] {
            for pagesDictionary in pagesDictionaries {
                if let pageText = pagesDictionary["text"] as? String {
                    let page = Page(number: 1, text: pageText)
                    bookPages.append(page)
                }
            }
        }
        pages = bookPages
    }
}

class Page {
    let number: Int
    let text: String

    init(number: Int, text: String) {
        self.number = number
        self.text = text
    }
}

