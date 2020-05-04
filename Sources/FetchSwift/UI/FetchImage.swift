//
//  File.swift
//
//
//  Created by Lova on 2020/5/3.
//

import Combine
import Foundation
import SwiftUI

class ImageLoader: ObservableObject {
    private let url: URL

    static var cache = ImageCache()
    @Published var image: UIImage?

    private var task: AnyCancellable?

    init(url: URL) {
        self.url = url
    }

    func load() {
        if let image = ImageLoader.cache[url] {
            self.image = image
            return
        }

        task = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .assign(to: \.image, on: self)
    }

//    private func cache(_ image: UIImage?) {
//        guard let iamge = image else {
//            return
//        }
//
//        ImageLoader.cache[url] = iamge
//    }

    func cancel() {
        task?.cancel()
    }

    deinit {
        task?.cancel()
    }
}

public
struct FetchImage<Placeholder: View>: View {
    @ObservedObject private var loader: ImageLoader
    private let placeholder: Placeholder?

    public init(_ url: URL, placeholder: Placeholder? = nil) {
        loader = ImageLoader(url: url)
        self.placeholder = placeholder
    }

    public var body: some View {
        image.onAppear(perform: loader.load)
            .onDisappear(perform: loader.cancel)
    }

    var name: String?

    private var image: some View {
        Group {
            if loader.image != nil {
                Image(uiImage: loader.image!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipped()
            } else {
                placeholder
            }
        }
    }
}

final class ImageCache: NSCache<NSURL, UIImage> {
    subscript(_ key: URL) -> UIImage? {
        get {
            object(forKey: key as NSURL)
        }
        set {
            newValue == nil ? removeObject(forKey: key as NSURL) : setObject(newValue!, forKey: key as NSURL)
        }
    }
}
