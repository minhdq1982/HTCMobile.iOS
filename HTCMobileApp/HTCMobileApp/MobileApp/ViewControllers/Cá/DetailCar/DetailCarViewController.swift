//
//  DetailCarViewController.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 11/8/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class DetailCarViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topHeaderView: UIView!
    let contentHeight: Variable<CGFloat> = Variable(10)
    let featureIndex: Variable<Int> = Variable(0)
    var carModel: CarModel?
    
    override func setupView() {
        super.setupView()
        
//        self.tableView.contentInset = UIEdgeInsets(top: -UIApplication.shared.statusBarFrame.size.height, left: 0, bottom: 0, right: 0)
//        self.tableView.bounces = false
        self.tableView.separatorStyle = .none
        
        self.tableView.register(DetailCarTableViewCell.nib, forCellReuseIdentifier: DetailCarTableViewCell.identifier)
        self.tableView.register(DetailCarHeaderCell.nib, forCellReuseIdentifier: DetailCarHeaderCell.identifier)
        self.tableView.register(UINib(nibName: "DetailCarFeatureHeaderView", bundle: Bundle.main), forHeaderFooterViewReuseIdentifier: "DetailCarFeatureHeaderView")
        self.tableView.delegate = self
        
        viewModel = DetailCarViewModel(service: HTCService())
        let source = DetailCarViewModel.Source(viewWillAppear: self.rx.viewWillAppear.take(1).asDriver(onErrorJustReturn: ()))
        
        let sink = (viewModel as! DetailCarViewModel).transform(source: source)
        self.bindData(sink)
    }
    
    override func localizable() {
        super.localizable()
    }
    
    override func bindData(_ sink: SinkType) {
        super.bindData(sink)
        
        if let sink = sink as? DetailCarViewModel.Sink {
            
            let dataSource = RxTableViewSectionedReloadDataSource<Section>(
                configureCell: {[weak self] ds, tv, ip, item in
                    
                    let cell = tv.dequeueReusableCell(withIdentifier: item.identifier, for: ip) as! BaseTableViewCell
                    cell.setDataContext(indexPath:ip,data: item )
                    guard let s = self else {return cell}
                    if let cell = cell as? DetailCarHeaderCell{
                        cell.delegate = self
                        cell.carModel = s.carModel
                    }else if let cell = cell as? DetailCarTableViewCell {
                        cell.carModel = s.carModel
                        cell.height.asDriver()
                            .drive(s.contentHeight)
                            .disposed(by: s.disposeBag)
                    }
                    return cell
                },
                titleForHeaderInSection: { ds, index in
                    return ds.sectionModels[index].header
            })
            
            sink.itemsSource
                .drive(self.tableView.rx.items(dataSource: dataSource))
                .disposed(by: disposeBag)
            
            contentHeight.asObservable()
                .skip(0)
                .filter{$0 > 0}
                .subscribe(onNext: {[weak self] (height) in
                    self?.tableView.contentSize = CGSize(width: UIScreen.main.bounds.size.width, height: 500 + 50 + height)
                }).disposed(by: disposeBag)
            
            tableView.rx.contentOffset
                .asObservable()
                .subscribe(onNext: {[weak self] (offset) in
                    self?.showHeaderHeaderByOffset(offset: offset)
                }).disposed(by: disposeBag)
        }
    }
    
    override func tapBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func showHeaderHeaderByOffset(offset: CGPoint) {
        if offset.y >= 500 {
            self.topHeaderView.isHidden = false
        }else {
            self.topHeaderView.isHidden = true
        }
    }
}

extension DetailCarViewController: DetailCarHeaderCellDelegate {
    func didTapCompareAction(car: CarModel){
        print("Compare")
        if let car = self.carModel {
            if let compareCarVC = R.storyboard.cars.compareCarsViewController() {
                compareCarVC.car1.value = car
                self.navigationController?.pushViewController(compareCarVC, animated: true)
            }
        }
    }
    func didTapRegisterDrive(car: CarModel) {
        print("Register drive")
        if let _ = self.carModel {
            if let registerVC = R.storyboard.cars.registerDriveCarViewController() {
                self.navigationController?.pushViewController(registerVC, animated: true)
            }
        }
    }
    func didTapPriceAdvice(car: CarModel){
        print("Price advice")
        if let _ = self.carModel {
            if let priceConsultingVC = R.storyboard.cars.priceConsultingViewController() {
                self.navigationController?.pushViewController(priceConsultingVC, animated: true)
            }
        }
    }
    func didTapDownloadCatalog(car: CarModel){
        if let _ = self.carModel {
            //  TODO download
        }
    }
    
    func didTapBackAction() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension DetailCarViewController: DetailCarFeatureHeaderViewDelegate{
    func didSelectFeature(feature: CategoryModel) {
        if let _ = self.carModel {
            if let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 1)) as? DetailCarTableViewCell {
                
                featureIndex.value = feature.getId()
                
                let htmlContent = "<h3><strong>Chuẩn bị:</strong></h3>\n\n<p>+ Khu vực rửa xe rộng r&atilde;i, tho&aacute;ng m&aacute;t, c&oacute; r&atilde;nh tho&aacute;ng nước.</p>\n\n<p>+ Dụng cụ rửa gồm: Chậu nước, khăn b&ocirc;ng mềm hay bọt biển, khăn rửa gầm v&agrave; b&aacute;nh xe, b&agrave;n chải v&agrave;&nbsp;<a href=\"https://thietbiruaxeoto.net/dung-dich-rua-may-o-to\">dung dịch rửa xe</a>&nbsp;chuy&ecirc;n dụng, chổi l&ocirc;ng hoặc m&aacute;y h&uacute;t bụi, nước rửa k&iacute;nh.</p>\n\n<p>+ Quan trọng l&agrave;&nbsp;<a href=\"https://thietbiruaxeoto.net/binh-bot-tuyet\">m&aacute;y rửa xe bọt tuyết</a>.</p>\n\n<h3><strong>Quy tr&igrave;nh rửa xe chuy&ecirc;n nghiệp</strong></h3>\n\n<p>Quy tr&igrave;nh rửa xe chuy&ecirc;n nghiệp c&agrave;n phải trải qua 5 bước cơ bản sau:</p>\n\n<p><strong>Bước 1:</strong>&nbsp;Xả sạch b&ugrave;n bẩn bằng c&aacute;ch d&ugrave;ng v&ograve;i nước xịt để xả hết c&aacute;c b&ugrave;n bẩn b&ecirc;n ngo&agrave;i.</p>\n\n<p><strong>Bước 2:</strong>&nbsp;Kiểm tra t&igrave;nh trạng xe: Nếu xe c&oacute; những vết bẩn như: nhựa đường, nhựa c&acirc;y, ph&acirc;n chim&hellip; th&igrave; phun chất tẩy nhựa c&acirc;y, ph&acirc;n chim (tham khảo t&iacute;nh năng sử dụng trước khi d&ugrave;ng)&hellip;l&ecirc;n vết bẩn để l&agrave;m mềm c&aacute;c chất rắn bẩn, sau đ&oacute; nhẹ nh&agrave;ng rửa sạch.</p>\n\n<p><strong>Bước 3:</strong>&nbsp;Rửa xe: D&ugrave;ng m&aacute;y rửa xe c&ugrave;ng dung dịch rửa xe chuy&ecirc;n dụng để rửa xe. D&ugrave;ng khăn b&ocirc;ng mềm hay bọt biển ch&agrave; rửa nhẹ to&agrave;n th&acirc;n xe. Rửa từng phần v&agrave; bắt đầu từ tr&ecirc;n xuống dưới, theo một hướng. Đồng thời xả nước li&ecirc;n tục trong qu&aacute; tr&igrave;nh rửa xe để l&agrave;m sạch ho&agrave;n to&agrave;n vết bẩn v&agrave; nước tẩy rửa. D&ugrave;ng b&agrave;n chải v&agrave; khăn (d&ugrave;ng để rửa gầm) để ch&agrave; rửa gầm xe v&agrave; b&aacute;nh xe.</p>\n\n<p><strong>Bước 4:</strong>&nbsp;Xả nhẹ lại bằng nước để xả tr&ocirc;i b&ugrave;n bẩn v&agrave; dung dịch tẩy rửa sau khi ho&agrave;n tất c&aacute;c phần của xe.</p>\n\n<p><strong>Bước 5:</strong>&nbsp;D&ugrave;ng khăn b&ocirc;ng mềm kh&ocirc; để lau kh&ocirc; xe. Kh&ocirc;ng n&ecirc;n để xe tự kh&ocirc; v&igrave; nước tự kh&ocirc; sẽ để lại vết mờ hoặc đọng nước tr&ecirc;n xe.</p>\n\n<h3><strong>C&aacute;c bước vệ sinh nội thất xe &ocirc; t&ocirc;</strong></h3>\n\n<p><strong>C&aacute;ch vệ sinh nội thất &ocirc; t&ocirc;</strong></p>\n\n<ul>\n\t<li>Vệ sinh gạt t&agrave;n thuốc: Trước ti&ecirc;n cần đổ hết t&agrave;n thuốc v&agrave; r&aacute;c rưởi trong hộp rồi rửa sạch hộp v&agrave; lau kh&ocirc; bằng khăn kh&ocirc;.</li>\n\t<li>Vệ sinh t&aacute;p l&ocirc;: Lau sạch bụi bẩn tr&ecirc;n t&aacute;p l&ocirc; bằng khăn ẩm, sau đ&oacute; lau lại bằng khăn kh&ocirc;.</li>\n\t<li>Lau sạch cửa k&iacute;nh: D&ugrave;ng khăn kh&ocirc; v&agrave; nước rửa k&iacute;nh để lau sạch c&aacute;c cửa k&iacute;nh tr&ecirc;n xe.</li>\n\t<li>Vệ sinh đệm s&agrave;n v&agrave; cabin: Th&aacute;o đệm s&agrave;n v&agrave; đệm cabin ra khỏi xe, giũ sạch. Bạn c&oacute; thể giặt sạch bằng b&agrave;n chải nếu đệm s&agrave;n qu&aacute; bẩn.</li>\n\t<li>H&uacute;t bụi: D&ugrave;ng chổi l&ocirc;ng hoặc m&aacute;y h&uacute;t bụi để l&agrave;m sạch bụi b&ecirc;n trong nội thất.</li>\n</ul>\n\n<h2><strong>Những điều cấm kỵ khi rửa xe &ocirc; t&ocirc;</strong></h2>\n\n<ul>\n\t<li>Kh&ocirc;ng rửa xe &ocirc; t&ocirc; trực tiếp dưới &aacute;nh nắng chiếu v&agrave;o xe.</li>\n\t<li>Tuyệt đối kh&ocirc;ng rửa xe khi xe c&ograve;n đang n&oacute;ng v&igrave; sẽ l&agrave;m ảnh hưởng đến chất lượng xe.</li>\n\t<li>Kh&ocirc;ng d&ugrave;ng nước rửa ch&eacute;n, bột giặt để rửa xe v&igrave; sẽ ảnh hưởng đến m&agrave;u sơn v&agrave; cấu tạo m&aacute;y.</li>\n\t<li>N&oacute;i &ldquo;kh&ocirc;ng&rdquo; với khăn nh&aacute;m hoặc khăn ni-l&ocirc;ng khi lau xe v&igrave; ch&uacute;ng sẽ l&agrave;m trầy xước lớp bảo vệ m&agrave;u sơn.</li>\n\t<li>Kh&ocirc;ng mang theo đồ trang sức kim loại như: nhẫn, v&ograve;ng kim loại, đồng hồ,&hellip;khi rửa xe v&igrave; sẽ l&agrave;m trầy xước xe.</li>\n\t<li>Tuyệt đối kh&ocirc;ng d&ugrave;ng x&ocirc; nước rửa xe v&agrave; khăn b&ocirc;ng gầm xe hoặc b&aacute;nh xe để vệ sinh, lau ch&ugrave;i th&acirc;n xe v&igrave; như vậy sẽ tạo n&ecirc;n nhiều vết trầy xước nhỏ tr&ecirc;n xe.</li>\n\t<li>Kh&ocirc;ng n&ecirc;n để xe bẩn trong một thời gian d&agrave;i rồi mới rửa xe v&igrave; vết bẩn để c&agrave;ng l&acirc;u c&agrave;ng trở n&ecirc;n cứng đầu.</li>\n</ul>\n\n<p>Chỉ cần thực hiện theo đ&uacute;ng kỹ thuật rửa xe &ocirc; t&ocirc; n&oacute;i tr&ecirc;n, xe của bạn sẽ lu&ocirc;n sạch v&agrave; bền như mới.</p>\n\n<p>Với b&agrave;i viết tr&ecirc;n hy vọng sẽ gi&uacute;p bạn c&oacute; th&ecirc;m được ch&uacute;t kinh nghiệm khi vệ sinh xe &ocirc; t&ocirc;. Ngo&agrave;i ra,&nbsp;<a href=\"https://thietbiruaxeoto.net/gioi-thieu-ve-cong-ty-son-tung-lam\"><em><strong>c&ocirc;ng ty Sơn T&ugrave;ng L&acirc;m</strong></em></a>&nbsp;đang cung cấp trọn bộ thiết bị rửa xe d&agrave;nh cho tiệm rửa xe chuy&ecirc;n nghiệp.</p>\n\n<p>Nếu c&aacute;c bạn c&oacute; nhu cầu mua thiết bị rửa xe th&igrave; h&atilde;y li&ecirc;n hệ theo số hotline 0915 877 096 hoặc 0905 007 066 để được tư vấn cụ thể hơn nh&eacute;!</p>\n\n<p>C&aacute;c bạn c&oacute; thể tham khảo video hướng dẫn<strong>&nbsp;</strong>kỹ thuật rửa xe &ocirc; t&ocirc; chuy&ecirc;n nghiệp tại đ&acirc;y.</p>\n\n<p>https://youtu.be/vnobTGlsnFM</p>\n"
                cell.content.value = htmlContent
                
//                switch feature.getId() {
//                case 0:
//                    cell.content.value = car.getHighlights()
//                case 1:
//                    cell.content.value = car.getExterior()
//                case 2:
//                    cell.content.value = car.getFurniture()
//                case 3:
//                    cell.content.value = car.getOperation()
//                case 4:
//                    cell.content.value = car.getSafe()
//                case 5:
//                    cell.content.value = car.getConvenient()
//                default:
//                    print("Thong so ky thuat")
//                }
            }
        }
    }
}

extension DetailCarViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 50
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            if let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "DetailCarFeatureHeaderView") as? DetailCarFeatureHeaderView {
                headerView.delegate = self
                headerView.currentIndex.value = featureIndex.value
                return headerView
            }
        }
        return UITableViewHeaderFooterView()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
