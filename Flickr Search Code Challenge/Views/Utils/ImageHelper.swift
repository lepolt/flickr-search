//
//  ImageHelper.swift
//  Flickr Search Code Challenge
//
//  Created by Jonathan Lepolt on 10/25/23.
//

import Foundation
import SwiftSoup

struct ImageHelper {
    // TODO JEL: We might be able to avoid using a 3rd party if we manually download the image, then find the
    // width/height of the UIImage or CGImage. This works [for now], but I don't really like it.
    /// Parses an HTML string to find the width and height of an image.
    /// I don't really like using a 3rd party dependency here, but since the width/height is an attribute in an HTML
    /// string, we are forced to do some string parsing. This 3rd party library does what I need given the time
    /// constraints.
    /// - Parameter html: The HTML. We expect to find an <img> tag here
    /// - Returns: CGSize of the image
    static func parseSize(html: String) -> CGSize {
        do {
            let doc: Document = try SwiftSoup.parse(html)

            guard let image = try doc.select("img").first() else { return .zero }

            let width = try Double(image.attr("width")) ?? 0
            let height = try Double(image.attr("height")) ?? 0

            return CGSize(width: width, height: height)
        } catch let error as NSError {
            print("Error parsing image description: \(error), \(error.userInfo)")
        }

        return .zero
    }

    /// Parses an HTML string to find the details URL for an image.
    /// - Parameter html: The HTML. We expect to find a <a> tag here
    /// - Returns: URL if we are able to create one
    static func parseHref(html: String) -> URL? {
        do {
            let doc: Document = try SwiftSoup.parse(html)

            // Find the link that points to this photo's details. This is a bit hacky for sure.
            let link = try doc.select("a").filter({ link in
                guard let href = try? link.attr("href") else {
                    return false
                }

                return href.contains("photos")
            })

            // Make sure we found a link to use
            guard let firstLink = link.first else { return nil }

            // Now get the HREF
            let linkHref = try firstLink.attr("href")

            return URL(string: linkHref)

        } catch let error as NSError {
            print("Error parsing image link: \(error), \(error.userInfo)")
        }

        return nil
    }
}
