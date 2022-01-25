//
//  SideMenuViewController.swift
//  Hart Store
//
//  Created by OPAYN LLC on 29/09/21.
//

import UIKit
import CoreMedia
import DropDown

class SideMenuViewController: UIViewController {
    
    //MARK: - IBOutlet Variables
    
    @IBOutlet weak var menuTab: UITableView!
    @IBOutlet weak var signedInView: UIView!
    @IBOutlet weak var SignedOutView: UIView!
    @IBOutlet weak var viewCoursesHeight: NSLayoutConstraint!
    @IBOutlet weak var profileImageView: SetImage!
    @IBOutlet weak var logoutBtn: UIButton!
    @IBOutlet weak var logoutVew: UIView!
    @IBOutlet weak var seprationUnderlineView: UIView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var userProfession: UILabel!
    @IBOutlet weak var appVersionLbl: UILabel!
    @IBOutlet weak var viewCoursesTop: NSLayoutConstraint!
    @IBOutlet weak var viewCoursesBottom: NSLayoutConstraint!
    @IBOutlet weak var guestSepratorLine: UIView!
    
    //MARK: - Variables
    
    var menuList: [Menu]!
    var menuOptions = ["Home", "All Products", "Search", "Category", "Discover", "Your Cart", "Your Account", "App Settings", "Logout"]
    var viewController: UIViewController!
    var isUserLoggedIn = true
    var signedInMenu = [[String]]()
    var selectedIndex = -1
    
    //MARK: - Life Cycles
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        
        logoutBtn.isHidden = false
        logoutVew.isHidden = false
        seprationUnderlineView.isHidden = false
        appVersionLbl.isHidden = false
        let nib = UINib(nibName: "SideMenuSectionHeader", bundle: nil)
        menuTab.register(nib, forHeaderFooterViewReuseIdentifier: "SideMenuSectionHeader")
        
        menuList = [Menu]()
        
        
        menuList.append(Menu(heading: "Section1", subHeading: [subMenu(viewName: "My Classes",image: UIImage(named: "my classes-active")), subMenu(viewName: "Payments",image: UIImage(named: "cash"))], collapsed: false))
        
        menuTab.reloadData()
        
        viewCoursesHeight.constant = 0
       // viewCoursesTop.constant = 4
        //viewCoursesBottom.constant = 4
        self.signedInView.isHidden = false
      //  self.SignedOutView.isHidden = true
        profileImageView.sd_setImage(with: URL(string: UserDefault.sharedInstance?.getUserDetails()?.image ?? ""), placeholderImage: UIImage(named: "user-white"), options: .highPriority, context: nil)
        self.userNameLbl.text = (UserDefault.sharedInstance?.getUserDetails()?.name ?? "N/A").capitalized
        self.userProfession.text = (UserDefault.sharedInstance?.getUserDetails()?.userCategory?.name ?? "N/A").capitalized
        self.menuTab.separatorStyle = .none
        self.menuTab.tableFooterView = UIView()
        self.guestSepratorLine.isHidden = true
        
        menuTab.reloadData()
        
        NotificationCenter.default.post(name: .trackPresentedScreen, object: ["screen":self])
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    //MARK: - Objc Methods
    
    @objc func didTapCollapseBtn(sender:UIGestureRecognizer){
        
        if !isUserLoggedIn{
            let section = sender.view?.tag ?? 0
            let collapsed = menuList[section].collapsed
            menuList[section].collapsed = !collapsed
            
            if selectedIndex == (sender.view?.tag ?? 0){
                selectedIndex = -1
            }
            else{
                self.selectedIndex = (sender.view?.tag ?? 0)
            }
         
            self.menuTab.reloadRows(at: [IndexPath(row: sender.view?.tag ?? 0, section: 0)], with: .automatic)
        }
    }
    
    //MARK: - IBActions
    
    @IBAction func tapCancelBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tappedCrossBtn(_ sender: UIButton) {
        
    }
    
    @IBAction func tappedViewAllCourses(_ sender: UIButton) {
//        let vc = storyBoardIdentifiers.main.getStoryBoard().instantiateViewController(withIdentifier: "CoursesListViewController") as! CoursesListViewController
//        vc.hidesBottomBarWhenPushed = true
//        self.viewController.navigationController?.pushViewController(vc, animated: true)
        self.dismiss(animated: true, completion: nil)
        self.viewController.tabBarController?.selectedIndex = 1
    }
    
    @IBAction func tappedLogoutBtn(_ sender: UIButton) {
        
        UserDefault.sharedInstance?.removeUserData()
        UserDefault.sharedInstance?.updateUserData()
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        vc.hidesBottomBarWhenPushed = true
        vc.hideBack = true
        self.viewController.navigationController?.pushViewController(vc, animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tappedLoginBtn(_ sender: UIButton) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        vc.hidesBottomBarWhenPushed = true
        vc.hideBack = true
        self.viewController.navigationController?.pushViewController(vc, animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tppedEditProfile(_ sender: UIButton) {
        
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "EditProfileViewController") as! EditProfileViewController
//        vc.hidesBottomBarWhenPushed = true
//        self.viewController.navigationController?.pushViewController(vc, animated: true)
//        self.dismiss(animated: true, completion: nil)
    }
    
}

//MARK: - TableView Functions

extension SideMenuViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
      
        return menuList.count
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuList[section].subHeading.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LoggedInUserCell") as! SideMenuTableViewCell
        cell.viewName.text = menuList[indexPath.section].subHeading[indexPath.row].viewName
        cell.viewIcon.image = menuList[indexPath.section].subHeading[indexPath.row].image
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
     
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "SideMenuSectionHeader") as! SideMenuSectionHeader
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row{
        
        case 0:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainDashboardViewController") as! MainDashboardViewController
            self.dismiss(animated: true, completion: {
                self.viewController.navigationController?.pushViewController(vc, animated: true)
            })
        
           
            break
            
        case 1:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "PaymentListViewController") as! PaymentListViewController
           
            self.dismiss(animated: true, completion: {
                self.viewController.navigationController?.pushViewController(vc, animated: true)
            })
            
        default:
            break
        }
    }
    
}
