//
//  PaymentListViewController.swift
//  IletsLearning
//
//  Created by OPAYN LLC on 24/11/21.
//

import UIKit
import SideMenu

class PaymentListViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var paymentTab: UITableView!
    @IBOutlet weak var noDataLbl: UILabel!
    
    //MARK: - variables
    
    var viewModel = PaymentListViewModel()
    let dateFormatter = DateFormatter()
    var isApiLoaded = false
    
    //MARK: - life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
//        navigationWithBack(navtTitle: "Payment History", titleType: .large, titleColor: .black)
        self.bothSideIcons(titleString: "Payment History", titleType: .large, leftIcon: UIImage(named: "barIcon")!, rightIcon: UIImage(), titleColor: .black, leftBtnType: .menu, rightBtnType: .addFeed)
        navigationButtonsDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getPaymentList()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.bothSideIcons(titleString: "Payment History", titleType: .large, leftIcon: UIImage(named: "barIcon")!, rightIcon: UIImage(), titleColor: .black, leftBtnType: .menu, rightBtnType: .addFeed)
        navigationButtonsDelegate = self
    }

}

//MARK: - TableView Delegate

extension PaymentListViewController: UITableViewDelegate, UITableViewDataSource{
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        if viewModel.paymentListModel.count == 0{
            
            if isApiLoaded{
                tableCollectionErrors(view: tableView, text: "No data found", headerHeight: 0)
                return viewModel.paymentListModel.count
            }
            else{
                tableCollectionErrors(view: tableView, text: "", headerHeight: 0)
                return 5
            }
            
        }
        else{
            tableCollectionErrors(view: tableView, text: "", headerHeight: 0)
            return viewModel.paymentListModel.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PackagesTableViewCell") as! PackagesTableViewCell
        
        if viewModel.paymentListModel.count == 0{
            cell.contentView.showSkeleton()
        }
        else{
            cell.contentView.hideSkeleton()
            
            let model = viewModel.paymentListModel[indexPath.row]
            
            if model.onlineClassID != nil{
                cell.packageType.text = "(Online Class)"
                cell.courseImage.sd_setImage(with: URL(string: model.onlineClassID?.first?.thumbnail ?? ""), placeholderImage: UIImage(named: "placeholderImage"), options: .highPriority, context: nil)
                cell.nameLbl.text = model.onlineClassID?.first?.title ?? ""
            }
            else if model.courseID != nil{
                cell.packageType.text = "(Course)"
                cell.courseImage.sd_setImage(with: URL(string: model.courseID?.thumbnail ?? ""), placeholderImage: UIImage(named: "placeholderImage"), options: .highPriority, context: nil)
                cell.nameLbl.text = model.courseID?.title ?? ""
            }
            else{
                cell.packageType.text = "(Package)"
               // cell.courseImage.sd_setImage(with: URL(string: model.onlineClassID?.thumbnail ?? ""), placeholderImage: UIImage(named: "placeholderImage"), options: .highPriority, context: nil)
                cell.nameLbl.text = "N/A"
                //model.onlineClassID?.title ?? ""
            }
            
            switch model.status ?? 0 {
                
            case 0:
                //Pending
                cell.paymentStatusLbl.text = "Pending"
                cell.paymentStatusLbl.textColor = .systemYellow
                break
                
            case 1:
                //Success
                
                cell.paymentStatusLbl.text = "Success"
                cell.paymentStatusLbl.textColor = .systemGreen
                
                break
                
            case 2:
                //Failure
                
                cell.paymentStatusLbl.text = "Failed"
                cell.paymentStatusLbl.textColor = .systemRed
                
                break
                
            default:
                break
            }
            cell.amountLbl.text = "$\(model.onlineClassID?.first?.price ?? 0)"
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let buyDate = dateFormatter.date(from: model.paymentID?.createdAt ?? "")
            dateFormatter.dateFormat = "dd MMM, yyyy"
            cell.paidOnDate.text = dateFormatter.string(from: buyDate ?? Date())
            cell.paideBy.text = "Paid By: \(model.userID?.name ?? "") (\(model.userID?.email ?? ""))"
        }
        
        if indexPath.row == (viewModel.paymentListModel.count - 1){
            cell.packageMainViewBottom.constant = 0.3
        }
        else{
            cell.packageMainViewBottom.constant = 0
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        let model = viewModel.paymentListModel[indexPath.row]
//
//        if model.onlineClassID != nil{
//
//        }
//        else if model.courseID != nil{
//
//            let vc = storyBoardIdentifiers.main.getStoryBoard().instantiateViewController(withIdentifier: "VideoPlayViewController") as! VideoPlayViewController
//            vc.courseId = model.onlineClassID?.id ?? 0
//            navigationController?.pushViewController(vc, animated: true)
//        }
//        else{
//         //   cell.packageType.text = "(Package)"
//        }
//
    }
    
}

//MARK: - Navigation button delegate

extension PaymentListViewController: customNavigationDelegates{
    
    func didTapRightButton(buttonType type: rightButtontype){
        if  type == .cart{
            
        }
    }
    
    func didTapLeftbutton(buttonType type: LeftButtonType) {
        if type == .menu{
            let vc = storyBoardIdentifiers.main.getStoryBoard().instantiateViewController(withIdentifier: "SideMenuViewController") as! SideMenuViewController
            let menu = SideMenuNavigationController(rootViewController: vc)
            menu.leftSide = true
            menu.presentationStyle = .menuSlideIn
            menu.menuWidth = self.view.bounds.width
            menu.presentDuration = 0.25
            vc.viewController = self
            menu.isNavigationBarHidden = true
            self.present(menu, animated: true, completion: nil)
            
        }
    }
}

//MARK: - Api Call

extension PaymentListViewController{
    
    func getPaymentList(){
        viewModel.getPaymentListApi(completion: {(isSuccess, message) in
            self.isApiLoaded = true
            if isSuccess{
                self.paymentTab.reloadData()
            }else{
                self.showToast(message: message)
            }
        })
    }
}
