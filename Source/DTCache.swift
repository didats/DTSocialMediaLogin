//
//  DTCache.swift
//  Academy
//
//  Created by Didats Triadi on 19/04/19.
//  Copyright © 2019 Rimbunesia. All rights reserved.
//

import UIKit

class DTCache {
    var cache = NSCache<AnyObject, AnyObject>()
    private let manager = FileManager.default
    static let shared = DTCache()
    
    init() {
        self.createWrapperDirectory()
    }
    
    private func wrapper() -> URL? {
        guard var dir = manager.urls(for: .cachesDirectory, in: .allDomainsMask).first else {
            return nil
        }
        dir.appendPathComponent("rimbunesia-cache")
        print("\n\nDirectory: \(dir)\n\n")
        
        return dir
    }
    
    private func createWrapperDirectory() {
        if let wrapperDir = wrapper() {
            if !manager.isReadableFile(atPath: wrapperDir.path) {
                do {
                    try manager.createDirectory(atPath: wrapperDir.path, withIntermediateDirectories: true, attributes: nil)
                }
                catch let error {
                    print("Error: \(error)")
                }
            }
        }
    }
    
    func save(_ obj: Any, key: String) {
        guard let wrapper = wrapper() else {
            return
        }
        let path = wrapper.appendingPathComponent("cache-\(key)")
        if let image = obj as? UIImage {
            guard let data = image.pngData() else {
                return
            }
            saveData(data, at: path)
        }
        else {
            let data = NSKeyedArchiver.archivedData(withRootObject: obj)
            saveData(data, at: path)
        }
    }
    
    private func saveData(_ data: Data, at path: URL) {
        if manager.isReadableFile(atPath: path.path) {
            do {
                try manager.removeItem(at: path)
            }
            catch let error {
                print("Error removing item: \(error.localizedDescription)")
            }
        }
        
        manager.createFile(atPath: path.path, contents: data, attributes: nil)
    }
    
    func hasObject(withKey: String, isImage: Bool = false) -> Any? {
        guard let wrapper = wrapper() else {
            return nil
        }
        
        let path = wrapper.appendingPathComponent("cache-\(withKey)")
        if manager.isReadableFile(atPath: path.path) {
            guard let data = manager.contents(atPath: path.path) else {
                return nil
            }
            if isImage {
                return UIImage(data: data)
            }
            else {
                return NSKeyedUnarchiver.unarchiveObject(with: data)
            }
        }
        
        return nil
    }
    
    func delete(key: String) {
        guard let wrapper = wrapper() else {
            return
        }
        let path = wrapper.appendingPathComponent("cache-\(key)")
        if manager.isReadableFile(atPath: path.path) {
            do {
                try manager.removeItem(at: path)
            }
            catch let error {
                print("Error removing item: \(error.localizedDescription)")
            }
        }
    }
}
