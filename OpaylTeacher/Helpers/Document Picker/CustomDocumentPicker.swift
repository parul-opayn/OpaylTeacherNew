//
//  CustomDocumentPicker.swift
//  IletsLearning
//
//  Created by OPAYN on 21/01/22.

import Foundation
import UIKit
import MobileCoreServices

protocol DocumentPickerDelegate{
    func selectedDocxData(fileData: Data?, fileType: String?)
}

class DocumentPicker: NSObject, UIDocumentPickerDelegate, UINavigationControllerDelegate{
    
    var viewController = UIViewController()
    var delegate: DocumentPickerDelegate!
    var fileData: Data!
    var fileType: String!

    var docPicker = UIDocumentPickerViewController(documentTypes: ["com.microsoft.word.doc","org.openxmlformats.wordprocessingml.document", kUTTypePDF as String,kUTTypePNG as String,kUTTypeJPEG as String], in: UIDocumentPickerMode.import)

    public init(showOnViewController: UIViewController, delegate: DocumentPickerDelegate){
        self.viewController = showOnViewController
        self.delegate = delegate
    }
    
    //MARK: - UsrDefined Func
    
    func showMenuPicker(view:UIView){
        
        let optionMenu = UIAlertController(title: nil, message: "", preferredStyle: .actionSheet)
        
        let docxAction = UIAlertAction(title: "Document", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.showDocumentPicker()
        })
        
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
        })

        optionMenu.addAction(docxAction)
        optionMenu.addAction(cancelAction)
        
        if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad {
            
            let popUp = UIPopoverController(contentViewController: optionMenu)
            
            popUp.present(from: CGRect(x: 15, y: view.frame.height - 150, width: 0, height: 0),
                          in: view, permittedArrowDirections: UIPopoverArrowDirection.any, animated: true)
            }
        else {
            viewController.present(optionMenu, animated: true, completion: nil)
        }
    }
    
    
    func showDocumentPicker(){
        docPicker.delegate = self
        self.viewController.present(docPicker, animated: true, completion: nil)
    }
    
    
    //MARK: - Docx Picker Func
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        let myURL = url as URL
                  print("import result : \(myURL)")
        do {
            fileData = try Data(contentsOf: myURL)
            
            let myURLString = url.path
            
            if myURLString.contains(".docx"){
                fileType = "docx"
            }
            else if myURLString.contains(".PNG") || myURLString.contains(".JPEG") || myURLString.contains(".JPEG") || myURLString.contains(".HEIC"){
                fileType = "jpeg"
            }
            else if myURLString.contains("GIF"){
                fileType = "gif"
            }
            else{
                fileType = "pdf"
            }
            delegate.selectedDocxData(fileData: fileData, fileType: fileType)
        } catch {
            print("no data")
        }
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
                print("view was cancelled")
        viewController.dismiss(animated: true, completion: nil)
    }
    
}
