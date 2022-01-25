//
//  PDFViewController.swift
//  IletsLearning
//
//  Created by OPAYN on 08/11/21.
//

import UIKit
import PDFKit

class PDFViewController: UIViewController{
    
    var fileUrl:URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let pdfView = PDFView(frame: view.frame)
        
        Indicator.shared.showProgressView(pdfView)
        
        DispatchQueue.global(qos: .background).async {
           
            if let url = self.fileUrl,
               let pdfDocument = PDFDocument(url: url) {
                
                pdfView.displayMode = .singlePageContinuous
                pdfView.autoScales = true
                pdfView.displayDirection = .vertical
              
               
                DispatchQueue.main.async {
                    pdfView.document = pdfDocument
                    self.view.insertSubview(pdfView, at: 0)
                    Indicator.shared.hideProgressView()
                    
                }
               
            }
            else{
                
                DispatchQueue.main.async {
                    Indicator.shared.hideProgressView()
                    self.showToast(message: "Invalid File Url or Format")
                }
              
            }
        }

    }
    
    @IBAction func tappedDoneBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
