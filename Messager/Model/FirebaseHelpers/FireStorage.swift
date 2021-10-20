//
//  FireStorage.swift
//  Messager
//
//  Created by minmin on 2021/10/14.
//

import Foundation
import FirebaseStorage
import ProgressHUD

let storage = Storage.storage()

class FileStorage {

    class func uploadImage(_ image: UIImage, directory: String, completion: @escaping(_ documentLink: String?) -> Void) {
        let storageRef = storage.reference(forURL: kFILEREFERENCE).child(directory)
        let imageData = image.jpegData(compressionQuality: 0.6)

        var task: StorageUploadTask!

        task = storageRef.putData(imageData!, metadata: nil,completion: { metadata, error in
            task.removeAllObservers()
            ProgressHUD.dismiss()

            if error != nil {

                return
            }
            storageRef.downloadURL { url, error in
                guard let downloadUrl = url else {
                    completion(nil)
                    return
                }
                completion(downloadUrl.absoluteString)
            }
        })
        task.observe(StorageTaskStatus.progress) { snapshot in
            let progress = snapshot.progress!.completedUnitCount / snapshot.progress!.totalUnitCount
            ProgressHUD.showProgress(CGFloat(progress))
        }
    }

    class func downloadImage(imageUrl: String, comletion: @escaping(_ image: UIImage?) -> Void) {
let imageFileName = fileeNameFrom(fileUrl: imageUrl)

        if fileExsistAtPath(path: imageFileName) {
            print("We have local image")
            //get it locally
            if let contentsOfFile = UIImage(contentsOfFile: fileInDocumentsDirectory(fileName: imageFileName)) {
                comletion(contentsOfFile)
            } else {
                print("could not convert local image")
                comletion(UIImage(named: "avatar"))

            }

        } else {
            //download from FB
            print("Lets get from FB")
            if imageUrl != "" {
                let   documentUrl = URL(string: imageUrl)
                let downloadQueue = DispatchQueue(label: "imageDownloadQueue")
                downloadQueue.async {
                    let data = NSData(contentsOf: documentUrl!)

                    if data != nil {
                        //Save locally
                        FileStorage.saveFileLocally(fileData: data!, fileName: imageFileName)

                        DispatchQueue.main.async {
                            comletion(UIImage(data: data! as Data))
                        }

                    } else {
                        print("no document in database")
                        comletion(nil)
                    }
                }
            }
        }
    }


    // MARK: - Save Locally
    class func saveFileLocally(fileData: NSData, fileName: String) {
        let docUrl = getDocumentURL().appendingPathComponent(fileName, isDirectory: false)
        fileData.write(to: docUrl, atomically: true)
    }


}

// MARK: - Helpers
func fileInDocumentsDirectory(fileName: String) -> String {
    return getDocumentURL().appendingPathComponent(fileName).path
}


func getDocumentURL() -> URL {
    return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
}

func fileExsistAtPath(path: String) -> Bool {

    return FileManager.default.fileExists(atPath: fileInDocumentsDirectory(fileName: path))
}
