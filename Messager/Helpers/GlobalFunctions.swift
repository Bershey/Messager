//
//  GlobalFunctions.swift
//  Messager
//
//  Created by minmin on 2021/10/14.
//

import Foundation

func fileeNameFrom(fileUrl: String) -> String {
   return ((fileUrl.components(separatedBy: "_").last)!.components(separatedBy: "?").first!).components(separatedBy: ".").first!
}
