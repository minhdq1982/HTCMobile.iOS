//
//  HomeViewController.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 10/23/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxDataSources

class HomeViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profileButton: UIButton!
    
    var homeRefresh: RefreshHandler?
    
    var isLoggedIn: Variable<Bool> = Variable(UserPrefsHelper.shared.isLoggedIn())
    var isDisableLogin: Variable<Bool> = Variable(false)
    var sections: [Section] = []
    let cards: Variable<[CardModel]> = Variable([])
    let forceUpdate: Variable<Bool> = Variable(true)
    
    var listMembershipItem: [MembershipItem] = []
    
    let LOGIN_CELL_HEIGHT: CGFloat = 240
    let GROUP_CARD_CELL_HEIGHT: CGFloat = 335
    let BANNER_CELL_HEIGHT: CGFloat = 280
    let NEWS_CELL_HEIGHT: CGFloat = 220
    let SURVEY_CELL_HEIGHT: CGFloat = 208
    let CONTACT_US_CELL_HEIGHT: CGFloat = 170
    let HEADER_HEIGHT: CGFloat = 65
    
    override func setupView() {
        super.setupView()
        
        print("AccesToken: \(UserPrefsHelper.shared.getAccessToken())")
        
        self.homeRefresh = RefreshHandler(view: self.tableView)
        guard let refreshHandler = homeRefresh else {return}
        
        self.tableView.register(GroupCardCell.nib, forCellReuseIdentifier: GroupCardCell.identifier)
        self.tableView.register(HomeLoginCell.nib, forCellReuseIdentifier: HomeLoginCell.identifier)
        self.tableView.register(HomeAddCardCell.nib, forCellReuseIdentifier: HomeAddCardCell.identifier)
//        self.tableView.register(BannerAutoScrollCell.nib, forCellReuseIdentifier: BannerAutoScrollCell.identifier)
        self.tableView.register(BannerCell.nib, forCellReuseIdentifier: BannerCell.identifier)
        self.tableView.register(ScrollPromotionCell.nib, forCellReuseIdentifier: ScrollPromotionCell.identifier)
        self.tableView.register(HomeHeaderViewCell.nib, forCellReuseIdentifier: HomeHeaderViewCell.identifier)
        self.tableView.register(HomeSurveyCell.nib, forCellReuseIdentifier: HomeSurveyCell.identifier)
        self.tableView.register(ContactUsCell.nib, forCellReuseIdentifier: ContactUsCell.identifier)
        self.tableView.sectionHeaderHeight = 0.000001
        self.tableView.backgroundColor = Colours.themeColor
        
        viewModel = HomeViewModel(service: HTCService())
        let source = HomeViewModel.Source(
            viewWillAppear: self.rx.viewWillAppear.asDriver(onErrorJustReturn: ()),
            isLoggedIn:isLoggedIn.asDriver(),
            isDisableLogin: isDisableLogin.asDriver(),
            refreshAction: refreshHandler.refresh.asDriver(onErrorJustReturn: ()),
            forceUpdate: forceUpdate.asDriver())
        
        let sink = (viewModel as! HomeViewModel).transform(source: source)
        self.bindData(sink)
        
        NotificationCenter.default.addObserver(self, selector: #selector(loginStatusChange), name: .DidChangeLoggedInStatus, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        appDelegate.tabbar?.setHidden(false)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.forceUpdate.value = false
        super.viewDidDisappear(animated)
    }
    
    override func localizable() {
        super.localizable()
        self.setHeaderTitle("")//tr(L10n.homeTitle)
    }
    
    override func bindData(_ sink: SinkType) {
        super.bindData(sink)
        
        if let sink = sink as? HomeViewModel.Sink {
            
            sink.itemsSource.asObservable()
                .subscribe(onNext: {[weak self] (sections) in
                    self?.sections.removeAll()
                    self?.sections += sections
                }).disposed(by: disposeBag)
            
            let dataSource = RxTableViewSectionedReloadDataSource<Section>(
                configureCell: {[weak self] ds, tv, ip, item in
                    let cell = tv.dequeueReusableCell(withIdentifier: item.identifier, for: ip) as! BaseTableViewCell
                    cell.setDataContext(indexPath:ip,data: item )
                    if let cell = cell as? GroupCardCell{
                        cell.delegate = self
                    }else if let cell = cell as? HomeLoginCell {
                        cell.delegate = self
                    }else if let cell = cell as? HomeAddCardCell {
                        cell.delegate = self
                    }else if let cell = cell as? BannerCell {
                        cell.delegate = self
                    }else if let cell = cell as? ScrollPromotionCell {
                        cell.delegate = self
                    }else if let cell = cell as? HomeHeaderViewCell {
                        cell.delegate = self
                    }
//                    else if let cell = cell as? HomeSurveyCell {
//                     
//                    }
                    else if let cell = cell as? ContactUsCell {
                        cell.delegate = self
                    }
                    return cell
                },
                titleForHeaderInSection: { ds, index in
                    return ds.sectionModels[index].header
            })
            
            sink.itemsSource
                .drive(self.tableView.rx.items(dataSource: dataSource))
                .disposed(by: disposeBag)
            
            sink.listMembership.asObservable()
                .subscribe(onNext: { [weak self] (cards) in
                    guard let s = self else { return }
                    s.cards.value = cards
                }).disposed(by: disposeBag)
            
            self.tableView.rx
                .modelSelected(Any.self)
                .subscribe(onNext: { (homeSurvey) in
                    if homeSurvey is HomeSurveyModel {
                        self.showSurveys()
                    }
                }).disposed(by: disposeBag)
            
            
            // test good news
            profileButton.rx.tap
                .asObservable()
                .subscribe(onNext: {[weak self] (_) in
                    if self?.isLoggedIn.value == true {
                        //  Show profile
                        self?.showUserProfile()
                    }else {
                        self?.loginAction()
                    }
                }).disposed(by: disposeBag)
            
            //  Handle end refresh animation
            guard let refreshHandler = self.homeRefresh else {return}
            refreshHandler.refresh.asObservable()
                .subscribe(onNext: {[weak self] _ in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                        self?.homeRefresh?.end()
                    })
                }).disposed(by: disposeBag)
        }
    }
    
    override func executeError(error: Error) {
        print("Do nothing")
    }
    
    @objc func loginStatusChange() {
        forceUpdate.value = true
        isLoggedIn.value = UserPrefsHelper.shared.isLoggedIn()
    }
        
    func showUserProfile() {
        if let userVC = R.storyboard.user.userProfileViewController() {
            self.navigationController?.pushViewController(userVC, animated: true)
        }
    }
    
    func showSurveys() {
        if let surveysVC = R.storyboard.surveys.surveyServicesViewController() {
            self.navigationController?.pushViewController(surveysVC, animated: true)
        }
    }
    
}


extension HomeViewController: GroupCardCellDelegate {
    func addCard() {
        if let addCardVC = R.storyboard.addMember.addMemberViewController() {
            navigationController?.pushViewController(addCardVC, animated: true)
        }
    }
    
    func useCard(card: CardModel){
        
        if let alert = R.storyboard.useCardAlert.useCardAlertViewController() {
            alert.providesPresentationContextTransitionStyle = true
            alert.definesPresentationContext = true
            alert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            alert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            
            alert.cardNo = card.getCardNo()
            alert.rank = card.getRank()
            alert.brand = card.getAgencyNameDisplay()
            
            appDelegate.tabbar?.present(alert, animated: true, completion: nil)
        }
    }
    func viewProfitCards(cards: [CardModel]){
        if let benefitVC = R.storyboard.user.benefitListViewController() {
            benefitVC.membershipCards.value = self.cards.value
            navigationController?.pushViewController(benefitVC, animated: true)
        }
    }
    func viewCardInfo(card: CardModel){
        if let detailVC = R.storyboard.user.detailCardViewController() {
          
            var agencySet = Set<String>()
            for i in 0..<cards.value.count {
                agencySet.insert(cards.value[i].agency?.getName() ?? "")
            }
            for name in agencySet {
                let items = cards.value.filter{$0.agency?.getName() == name}
                print("Set: \(name)")
                self.listMembershipItem.append(MembershipItem(isExpand: false, title: name, cards: items))
            }
            
            detailVC.listMembershipItem = self.listMembershipItem
            detailVC.memberCardItems.value = self.cards.value
            for i in 0..<self.cards.value.count {
                if cards.value[i].getId() == card.getId() {
                    detailVC.indexItem.value = i
                }
            }
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    func loginAction() {
        if let loginVC = R.storyboard.login.loginViewController() {
            navigationController?.pushViewController(loginVC, animated: true)
        }
    }
}

extension HomeViewController: HomeHeaderViewCellDelegate {
    func didTapGroupNews(group: GroupNewsHeaderModel) {
        if let newsVC = R.storyboard.news.goodNewsViewController() {
            self.navigationController?.pushViewController(newsVC, animated: true)
            newsVC.groupNews = group
            newsVC.title = group.getName()
        }
    }
}

extension HomeViewController: ScrollPromotionCellDelegate {
    func viewNews(_ news: NewsModel) {
        if let newsDetailVC = R.storyboard.news.newsDetailViewController() {
            newsDetailVC.news = news
            self.navigationController?.pushViewController(newsDetailVC, animated: true)
        }
    }
}

extension HomeViewController: HomeLoginCellDelegate {
    func didTapLoginAction() {
        if let loginVC = R.storyboard.login.loginViewController() {
            navigationController?.pushViewController(loginVC, animated: true)
        }
    }
    
    func didTapDisableLoginCell() {
        UserPrefsHelper.shared.setDisableLoginSection(true)
        //  Update section
        isDisableLogin.value = true
    }
}

extension HomeViewController: HomeAddCardCellDelegate {
    func didTapAddTheFirstCard() {
        if let addCardVC = R.storyboard.addMember.addMemberViewController() {
            navigationController?.pushViewController(addCardVC, animated: true)
        }
    }
}

extension HomeViewController: BannerCellDelegate {
    func moveToSearchAgency() {
        if let nav = appDelegate.tabbar?.viewControllers?[4] as? UINavigationController {
            if let vc = nav.viewControllers[0] as?  SupportViewController {
                vc.quickAccessMap = true
                appDelegate.tabbar?.selectedIndex = 4
            }
        }
    }
    func moveToBuyCar(){
        appDelegate.tabbar?.selectedIndex = 1
    }
    func moveToRegisterDrive(){
        if let nav = appDelegate.tabbar?.viewControllers?[1] as? UINavigationController {
            if let registerVC = R.storyboard.cars.registerDriveCarViewController() {
                nav.pushViewController(registerVC, animated: true)
            }
        }
        appDelegate.tabbar?.selectedIndex = 1
    }
    func moveToRegisterApointment(){
        if let nav = appDelegate.tabbar?.viewControllers?[2] as? UINavigationController {
            if let addAppointmentVC = R.storyboard.services.addAppointmentViewController() {
                nav.pushViewController(addAppointmentVC, animated: true)
            }
        }
        appDelegate.tabbar?.selectedIndex = 2
    }
}

extension HomeViewController: ContactUsCellDelegate {
    func didTapHotline() {
        if let setting = appDelegate.setting {
            if let phoneNumber = setting.hotline?.replacingOccurrences(of: ".", with: "") {
                let phoneLink = "tel://\(phoneNumber)"
                if let url = URL(string: phoneLink) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
        }
    }
    func didTapFacebook(){
        
    }
    func didTapYoutube(){
        
    }
}

