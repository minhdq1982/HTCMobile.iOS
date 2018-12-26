//
//  CarInformationViewController.swift
//  HTCMobileApp
//
//  Created by admin on 10/29/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit
import RxDataSources

class CarInformationViewController: BaseViewController {
    // MARK: - Outlet
    @IBOutlet weak var addCarButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addCarLabel: UILabel!
    @IBOutlet weak var noDataLabel: UILabel!
    
    let cars: Variable<[UserCarModel]> = Variable([])
    let deleteCarID: Variable<Int> = Variable(-1)
    let isDeletingCar: Variable<Bool> = Variable(false)
    
    // MARK: - LifeCycle
    override func setupView() {
        super .setupView()
        self.tableView.register(CarUserCell.nib, forCellReuseIdentifier: CarUserCell.identifier)
       
        print("User cars: \(cars.value)")
        
        viewModel = UserCarViewModel(service: HTCService())
        let source = UserCarViewModel.Source(
            viewWillAppear: self.rx.viewWillAppear.take(1).asDriver(onErrorJustReturn: ()),
            cars: cars.asDriver(),
            deleteCarId: deleteCarID.asDriver(),
            isDeletingCar: isDeletingCar.asDriver())
        let sink = (viewModel as! UserCarViewModel).transform(source: source)
        self.bindData(sink)
     
    }
    
    override func localizable() {
        super .localizable()
    }
    
    override func bindData(_ sink: SinkType) {
        super .bindData(sink)
        if let sink = sink as? UserCarViewModel.Sink {
            
            // update status table
            self.cars.asObservable()
                .subscribe(onNext: {[weak self] (cars) in
                    guard let s = self else { return }
                    if cars.count == 0 {
                        s.noDataLabel.isHidden = false
                    } else {
                        s.noDataLabel.isHidden = true
                    }
                }).disposed(by: disposeBag)
            
            // delete Car
            sink.deleteCarResponse
                .asObservable()
                .subscribe(onNext: { [weak self] (response) in
                    guard let s = self else { return }
                    print("Delete: \(response)")
                    if response.getCode() == "200" {
                        for i in 0..<s.cars.value.count {
                            let item = s.cars.value[i]
                            if item.getId() == s.deleteCarID.value {
                                s.cars.value.remove(at: i)
                                break
                            }
                        }
                    }
                }).disposed(by: disposeBag)

            // set up table view
            sink.itemsSource
                .drive(self.tableView.rx.itemsSource())
                .disposed(by: disposeBag)
            
            tableView.rx
                .willDisplayCell
                .subscribe(onNext: { cell, indexPath in
                    if let cell = cell as? CarUserCell {
                        cell.delegate = self
                        
                    }
                })
                .disposed(by: disposeBag)
            }
        
            tableView.rx
                .modelSelected(UserCarModel.self)
                .asObservable()
                .subscribe({ [weak self] (userCarModel) in
                    if let model = userCarModel.element {
                        self?.moveToDetailCar(model)
                    }
                })
            .disposed(by: disposeBag)
            
    }
    // MARK: - functions
    @IBAction func onAddCar(_ sender: Any) {
        print("add Card")
        if let addCarVC = R.storyboard.user.detaillCarProfileViewController() {
            addCarVC.isAddCar.value = true
            navigationController?.pushViewController(addCarVC, animated: true)
        }
    }
    
    func moveToDetailCar(_ userCarModel: UserCarModel) {
        if let detailCar = R.storyboard.user.detaillCarProfileViewController() {
            detailCar.isAddCar.value = false
            detailCar.userCarModel = userCarModel
            self.navigationController?.pushViewController(detailCar, animated: true)
        }
    }
}

// MARK: - extension
extension CarInformationViewController: CarUserCellDelegate {
    func deleteCar(_ userCar: UserCarModel) {
        print("delete card")
        print(userCar.getId())
        let msg = "Bạn thực sự muốn xoá dữ liệu xe?"

        self.showConfirmMessage(message: msg, confirmAction: {
            self.isDeletingCar.value = true
            self.deleteCarID.value = userCar.getId()
        }) {
            print("cancel")
        }

        
    }
}
//extension CarInformationViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 0
//    }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 160
//    }
//}
