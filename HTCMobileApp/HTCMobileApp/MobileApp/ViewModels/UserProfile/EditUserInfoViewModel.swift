//
//  EditUserInfoViewModel.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 11/22/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import Alamofire
import ObjectMapper

class EditUserInfoViewModel: BaseViewModel {
    func transform(source: EditUserInfoViewModel.Source) -> EditUserInfoViewModel.Sink {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        let updateAvatarSuccess: Variable<Bool> = Variable(false)
        let isUpdatingAvatar: Variable<Bool> = Variable(false)
        
        let isChangeUserInfo = Driver.combineLatest(source.user, source.name, source.birthDay, source.identifyId, source.email, source.address)
            .flatMap { (args) -> Driver<Bool> in
                let (user, name, birthDay, identifyId, email, address) = args
                var retValue = false
                
                if (user.getName() != name)
                    || user.getBirthdayDisplay() != birthDay
                    || user.getIdentifyCard() != identifyId
                    || user.getEmail() != email
                    || user.getAddress() != address {
                    retValue = true
                }
                return Driver.just(retValue)
        }
        
        let isEnableSaveButton = Driver.combineLatest(source.isChangeAvatar, isChangeUserInfo.asDriver())
            .flatMap { (args) -> Driver<Bool> in
                let (isChangeAvatar, isChangeUserInfo) = args
                return Driver.just((isChangeAvatar || isChangeUserInfo))
        }
        
        //  Call API update user avatar
        let changeAvatarInputs = Driver.combineLatest(source.isChangeAvatar, source.avatar)
        let saveAvatarResponse = source.saveAction
                .withLatestFrom(changeAvatarInputs)
                .filter{$0.0 == true}
                .flatMap { (args) -> Driver<User> in
                    
                    let (isChangeAvatar, image) = args
                    
                    if isChangeAvatar == true, let data = image.pngData() {
                        isUpdatingAvatar.value = true
                        self.updateAvatar(imageData: data, onCompletion: { _ in
                            updateAvatarSuccess.value = true
                            isUpdatingAvatar.value = false
                        }, onError: { _ in
                            updateAvatarSuccess.value = false
                            isUpdatingAvatar.value = false
                        })
//                        return self.service.getAllResponse(User.self, Api.default.updateAvatar(imageData: data))
//                            .trackActivity(activityIndicator)
//                            .trackError(errorTracker)
//                            .asDriverOnErrorJustComplete()
                    }
                    
                    return Driver.empty()
        }
        
        saveAvatarResponse.asObservable()
            .subscribe(onNext: { _ in
                
            }).disposed(by: disposeBag)
        
        let validationInputs = Driver.combineLatest(isChangeUserInfo, source.name, source.birthDay, source.identifyId, source.email)
        let validation = source.saveAction
            .withLatestFrom(validationInputs)
            .filter{$0.0 == true}
            .flatMap { (args) -> Driver<(Bool, String)> in

                let (_ ,name, birthday, identifier, email) = args

                var isValid = true
                var message = ""

                //  Validate user name
                if !name.isEmpty && !isValidName(name) {
                    message = "Họ tên sai định dạng"
                }
                
                if message.isEmpty {
                    //  Validate birthday
                    if !birthday.isEmpty && !isValidBirthday(birthday) {
                        message = "Ngày sinh không hợp lệ"
                    }
                }
                
                if message.isEmpty {
                    if !identifier.isEmpty && !isValidIdentifier(identifier) {
                        message = "Số chứng minh thư không hợp lệ"
                    }
                }
                
                if message.isEmpty {
                    if !email.isEmpty && !isValidEmail(email) {
                        message = "Email không hợp lệ"
                    }
                }

                if !message.isEmpty {
                    isValid = false
                }

                return Driver.just((isValid, message))
        }
        
        // Call API update user info
        let updateUserInputs = Driver.combineLatest(validation, isChangeUserInfo, source.name, source.birthDay, source.identifyId, source.email, source.address)
        let saveUserInfoResponse
            = source.saveAction
                .withLatestFrom(updateUserInputs)
                .filter{$0.0.0 == true && $0.1 == true}
                .flatMap { (args) -> Driver<User> in
                    
                    let (_, _, name, birthday, identifier, email, adress) = args
                    
                    return self.service.getItem(User.self, Api.default.updateProfile(name: name, identifyId: identifier, birthDay: DateUtils.shared().getBirthdayForUpdate(date: birthday), email: email, address: adress))
                        .trackActivity(activityIndicator)
                        .trackError(errorTracker)
                        .asDriverOnErrorJustComplete()
        }.startWith(User(name: "", avatar: "", phone: "", birthday: "", email: "", idenfierId: "", address: "", cars: [], cards: []))
        
        let cities: Variable<[CityModel]> = Variable([])
        if appDelegate.cities.value.count > 0 {
            cities.value += appDelegate.cities.value
        }else{
            let items = source.viewWillAppear
                .flatMap { _ -> Driver<[CityModel]> in
                    return self.service.getItems(CityModel.self, Api.default.getCities())
                        .trackActivity(activityIndicator)
                        .trackError(errorTracker)
                        .asDriverOnErrorJustComplete()
            }
            
            items.asObservable()
                .subscribe(onNext: { (items) in
                    if items.count > 0 {
                        cities.value.removeAll()
                        cities.value += items
                        appDelegate.cities.value += items
                    }
                }).disposed(by: disposeBag)
        }
        
        let updateUserSuccess = Driver.combineLatest(isChangeUserInfo, source.isChangeAvatar, saveUserInfoResponse, updateAvatarSuccess.asDriver())
            .flatMap { (args) -> Driver<Bool> in
                var retValue = false
                let (isChangeInfo, isChangeAvatar, user, successUpdateAvatar) = args
                
                if isChangeInfo == true  && isChangeAvatar == true {
                    if user.phone?.isEmpty == false  && successUpdateAvatar == true {
                        retValue = true
                    }
                }else if isChangeInfo == true && isChangeAvatar == false {
                    if user.phone?.isEmpty == false {
                        retValue = true
                    }
                }else if isChangeInfo == false && isChangeAvatar == true {
                    if successUpdateAvatar == true {
                        retValue = true
                    }
                }
                return Driver.just(retValue)
        }
        
        
        return Sink(updateUserSuccess: updateUserSuccess, isUpdatingAvatar: isUpdatingAvatar.asDriver(), isEnableSaveButton: isEnableSaveButton, validation: validation, cities: cities.asDriver(), fetching: activityIndicator.asDriver(), error: errorTracker.asDriver())
    }
    
    func updateAvatar(imageData: Data?, onCompletion: ((String?) -> Void)? = nil, onError: ((Error?) -> Void)? = nil)  {
        let url = "\(Api.default.getUrl())\(Constants.updateAvatar)"
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Api.default.accessToken)",
            "Content-type": "multipart/form-data"
        ]
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            if let data = imageData{
                multipartFormData.append(data, withName: "file", fileName: "user_profile.png", mimeType: "image/png")
            }
            
        }, usingThreshold: UInt64.init(), to: url, method: .post, headers: headers) { (result) in
            switch result{
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    print("Succesfully uploaded")
                    if let err = response.error{
                        onError?(err)
                        return
                    }
                    onCompletion?(nil)
                }
            case .failure(let error):
                print("Error in upload: \(error.localizedDescription)")
                onError?(error)
            }
        }
    }
    
}
extension EditUserInfoViewModel: ViewModelType {
    public struct Source :SourceType{
        public let viewWillAppear : Driver<Void>
        public let user: Driver<User>
        public let saveAction: Driver<Void>
        public let name: Driver<String>
        public let birthDay: Driver<String>
        public let identifyId: Driver<String>
        public let email: Driver<String>
        public let address: Driver<String>
        public let avatar: Driver<UIImage>
        public let isChangeAvatar: Driver<Bool>
        
        public init(viewWillAppear:Driver<Void>,
                    user: Driver<User>,
                    saveAction: Driver<Void>,
                    name: Driver<String>,
                    birthDay: Driver<String>,
                    identifyId: Driver<String>,
                    email: Driver<String>,
                    address: Driver<String>,
                    avatar: Driver<UIImage>,
                    isChangeAvatar: Driver<Bool>)
        {
            self.viewWillAppear = viewWillAppear
            self.user = user
            self.saveAction = saveAction
            self.name = name
            self.birthDay = birthDay
            self.identifyId = identifyId
            self.email = email
            self.address = address
            self.avatar = avatar
            self.isChangeAvatar = isChangeAvatar
        }
    }
    
    public struct Sink: SinkType {
//        public var saveUserResponse: Driver<User>
//        public var saveAvatarResponse: Driver<User>
//        public var updateAvatarSuccess: Driver<Bool>
        public var updateUserSuccess: Driver<Bool>
        public var isUpdatingAvatar: Driver<Bool>
        public var isEnableSaveButton: Driver<Bool>
        public var validation: Driver<(Bool, String)>
        public var cities: Driver<[CityModel]>
        public var fetching: Driver<Bool>?
        public var error: Driver<Error>?
    }
}
