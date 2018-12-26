//
//  SurveyPagerCell.swift
//  HTCMobileApp
//
//  Created by admin on 11/30/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import UIKit
import FSPagerView
import RxDataSources
import RxSwift
import RxCocoa


class SurveyPagerCell: BaseFSPagerViewCell {
    @IBOutlet weak var tableView: UITableView!
   
    let itemsSource: Variable<[Section]> = Variable([])
    
    override func setDataContext(index: Int, data: Any) {
        super.setDataContext(index: index, data: index)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 4.0
        self.tableView.register(SpinnerCell.nib, forCellReuseIdentifier: SpinnerCell.identifier)
        self.tableView.register(TitleCell.nib, forCellReuseIdentifier: TitleCell.identifier)
        self.tableView.register(DateCell.nib, forCellReuseIdentifier: DateCell.identifier)
        self.tableView.register(LevelCell.nib, forCellReuseIdentifier: LevelCell.identifier)
        self.tableView.register(RadioCell.nib, forCellReuseIdentifier: RadioCell.identifier)
        self.tableView.register(CheckBoxCell.nib, forCellReuseIdentifier: CheckBoxCell.identifier)
        self.tableView.register(TextCell.nib, forCellReuseIdentifier: TextCell.identifier)
       
        self.setNeedsLayout()
        self.layoutIfNeeded()
        
        
        let dataSource = RxTableViewSectionedReloadDataSource<Section>(
            configureCell: {[weak self] ds, tv, ip, item in
                let cell = tv.dequeueReusableCell(withIdentifier: item.identifier, for: ip) as! BaseTableViewCell
                cell.setDataContext(indexPath:ip,data: item )
                if let cell = cell as? SpinnerCell{
                    cell.delegate = self
                }else if let cell = cell as? CheckBoxCell {
                    cell.delegate = self
                }else if let cell = cell as? RadioCell {
                    cell.delegate = self
                }else if let cell = cell as? TextCell {
                    cell.delegate = self
                }else if let cell = cell as? DateCell {
                    cell.delegate = self
                }else if let cell = cell as? LevelCell {
                    cell.delegate = self
                }
              
                return cell
            },
            titleForHeaderInSection: { ds, index in
                return ds.sectionModels[index].header
        })
   
        
        itemsSource.asDriver()
            .drive(self.tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        
    }
    
    func dataSource(sources: [Section]) {
        itemsSource.value.removeAll()
        if sources.count > 0 {
            itemsSource.value += sources
        }
    }

}

extension SurveyPagerCell: SpinnerCellDelegate {
    func getSpinnerResult(_ id: Int, _ page: Int, _ question: String, _ answer: String, _ surveyType: String) {
        let result = ResultModel(id: id, page: page, question: question, answers: answer, surveyType: surveyType)
        
        switch ServiceQuestion.shared.indexPage {
        case 0:
            if result.getSurveyType() == "service" {
                ServiceResult.shared.addAnswerFirstPage(result: result)
            }
            break
        case 6:
            if result.getSurveyType() == "service" {
               ServiceResult.shared.addAnswerSeventhPage(result: result)
            }
            break
        case 8:
            if result.getSurveyType() == "service" {
                ServiceResult.shared.addAnswerNinethPage(result: result)
            }
            break
        default: break
            // dont anything
        }
    }
}
extension SurveyPagerCell: LevelCellDelegate {
    func getLevelResult(_ id: Int, _ page: Int, _ question: String, _ answer: String, _ surveyType: String) {
        print("level delegate")
       let result = ResultModel(id: id, page: page, question: question, answers: answer, surveyType: surveyType)
        
        switch ServiceQuestion.shared.indexPage {
        case 1:
            if result.getSurveyType() == "service" {
                ServiceResult.shared.addAnswerSecondPage(result: result)
            }
            break
        case 2:
            if result.getSurveyType() == "service" {
                ServiceResult.shared.addAnswerThirdPage(result: result)
            }
            break
        case 3:
            if result.getSurveyType() == "service" {
                ServiceResult.shared.addAnswerFourthPage(result: result)
            }
            break
        case 4:
            if result.getSurveyType() == "service" {
                ServiceResult.shared.addAnswerFifthPage(result: result)
            }
            break
        case 5:
            if result.getSurveyType() == "service" {
                ServiceResult.shared.addAnswerSixthPage(result: result)
            }
            break
        default: break
            // dont anything
        }
    }

}
extension SurveyPagerCell: RadioCellDelegate {
    func getRadioResult(_ id: Int, _ page: Int, _ question: String, _ answer: String, _ surveyType: String) {
        let result = ResultModel(id: id, page: page, question: question, answers: answer, surveyType: surveyType)
        switch ServiceQuestion.shared.indexPage {
        case 6:
            if result.getSurveyType() == "service" {
                ServiceResult.shared.addAnswerSeventhPage(result: result)
            }
            break
        case 7:
            if result.getSurveyType() == "service" {
                ServiceResult.shared.addAnswerEighthPage(result: result)
            }
            break
        case 8:
            if result.getSurveyType() == "service" {
                ServiceResult.shared.addAnswerNinethPage(result: result)
            }
            
            break
            
        default: break
            // dont anything
        }
    }
 
    
}
extension SurveyPagerCell: TextCellDelegate {
    func getTextResult(_ id: Int, _ page: Int, _ question: String, _ answer: String, _ surveyType: String) {
        let result = ResultModel(id: id, page: page, question: question, answers: answer, surveyType: surveyType)
        switch ServiceQuestion.shared.indexPage {
        case 0:
            if result.getSurveyType() == "service" {
                ServiceResult.shared.addAnswerFirstPage(result: result)
            }
        case 8:
            if result.getSurveyType() == "service" {
                ServiceResult.shared.addAnswerNinethPage(result: result)
            }
        case 9:
            if result.getSurveyType() == "service" {
                ServiceResult.shared.addAnswerTenthPage(result: result)
            }
            
            break
            
        default: break
            // dont anything
        }
    }

}
extension SurveyPagerCell: CheckBoxCellDelegate {
    func getCheckBoxResult(_ id: Int, _ page: Int, _ question: String, _ answer: String, _ surveyType: String) {
        let result = ResultModel(id: id, page: page, question: question, answers: answer, surveyType: surveyType)
        switch ServiceQuestion.shared.indexPage {
        case 7:
            if result.getSurveyType() == "service" {
                ServiceResult.shared.addAnswerEighthPage(result: result)
            }
        default: break
            // dont anything
        }
    }
    
    
}

extension SurveyPagerCell: DateCellDelegate {
    func getDateResult(_ id: Int, _ page: Int, _ question: String, _ answer: String, _ surveyType: String) {
        let result = ResultModel(id: id, page: page, question: question, answers: answer, surveyType: surveyType)
        switch ServiceQuestion.shared.indexPage {
        case 0:
            if result.getSurveyType() == "service" {
                ServiceResult.shared.addAnswerFirstPage(result: result)
            }
        default: break
            // dont anything
        }
    }
    
    
}

