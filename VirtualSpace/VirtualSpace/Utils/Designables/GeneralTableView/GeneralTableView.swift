// _________SKAIK_MO_________
//
//  GeneralTableView.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 22/07/2023.
//

import UIKit

class GeneralTableView: UITableView {

    // MARK: - Table Properties
    var objects: [Any] = [] {
        didSet {
            self.reloadData()
        }
    }
    var cell: UITableViewCell.Type = UITableViewCell.self {
        didSet {
            self._registerCell = cell.self
        }
    }

    var headerObject: Any?
    var hedaer: UITableViewHeaderFooterView.Type = UITableViewHeaderFooterView.self {
        didSet {
            self._registerHeaderAndFooter = hedaer.self
        }
    }

    var handlerDidFinishRequest: (() -> Void)?

    // MARK: - Empty Data Properties
    var headerHeight: CGFloat = 0
    var emptyImage: UIImage?
    var emptyTitle = ""
    var emptySubTitle = ""
//    var isShowEmptyData = false {
//        didSet {
////            self.cr.footer?.alpha = (self.isShowEmptyData && self.objects.isEmpty) ? 0 : 1
//        }
//    }

    // MARK: - PullToRefresh Properties
//    let control = UIRefreshControl.init()
//    var isPullToRefreshEnable: Bool = false {
//        didSet {
//            if self.isPullToRefreshEnable {
////                self.control.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
//                self.refreshControl = control
//            }
//        }
//    }

    // MARK: - LoadMore Properties
//    var isLoadMoreEnable: Bool = false {
//        didSet {
//            self.setCRRefresh()
//        }
//    }

    // MARK: - Request Properties
    private var totalPages: Int = 0
    private var pageNumber: Int = 0
    var request: GeneralController? = .none
    var isShowLoader: Bool = true

    override func awakeFromNib() {
        self.delegate = self
        self.dataSource = self
        self.separatorStyle = .none
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
        self.backgroundColor = .clear
//        self.emptyDataSetSource = self
//        self.emptyDataSetDelegate = self
        self.sectionHeaderHeight = 0
    }

}

// MARK: - PullToRefresh
extension GeneralTableView {

//    @objc private func pullToRefresh() {
////        self.resetTableView(request: self.request, isShowLoader: false)
//    }
//
//    func resetTableViewObjects(objects: [Any], isShowLoader: Bool = true) {
//        self.isShowLoader = isShowLoader
//        self.isShowEmptyData = false
////        self.reloadEmptyDataSet()
//        self.objects.removeAll()
//        self.objects = objects
//        self.isShowLoader = false
//    }
//
//    func resetTableView(request: GeneralController?, isShowLoader: Bool = true) {
//        self.isShowLoader = isShowLoader
//        self.totalPages = 0
//        self.pageNumber = 0
//        self.isShowEmptyData = false
//        self.reloadEmptyDataSet()
//        self.objects.removeAll()
//        self.cr.resetNoMore()
//        self.sendRequest(isAdd: false, request)
//        self.isShowLoader = false
//    }

}

// MARK: - Pagination (load more)
extension GeneralTableView {

    private func setCRRefresh() {
//        guard self.isLoadMoreEnable else { return }
//        self.cr.addFootRefresh(animator: NormalFooterAnimator()) {
//            let isNoMoreData = self.totalPages == self.pageNumber
//            if !isNoMoreData {
//                self.sendRequest(isAdd: true, self.request)
//            }
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
//                    self.cr.endLoadingMore()
//                    if isNoMoreData {
//                        self.cr.noticeNoMoreData()
//                    } else {
//                        self.cr.resetNoMore()
//                    }
//                })
//        }
    }
}

// MARK: - Request
extension GeneralTableView {
    func sendRequest(isAdd: Bool, _ request: GeneralController?) {
//    private func sendRequest(isAdd: Bool, _ request: GeneralController?) {
        self.pageNumber += 1
        self.request = request
        _ = request?.getFunc(pageNumber: pageNumber, isShowLoader: isShowLoader, handlerResponse: { objects, totalPages, pageNumber, headerObject in
            self.objects += objects
            self.totalPages = totalPages
            self.pageNumber = pageNumber
            self.headerObject = headerObject
            debugPrint("objects =>> \(self.objects.count) || totalPages =>> \(totalPages) pageNumber =>> \(pageNumber), headerObject =>> \(headerObject)")
        })?.handlerDidFinishRequest(handler: {
            self.emptyDataSet(headerHeight: self.headerHeight, image: self.emptyImage, title: self.emptyTitle, subTitle: self.emptySubTitle, titleFont: .poppinsMedium17, subTitleFont: .poppinsMedium13)
//            self.control.endRefreshing()
//            self.isShowEmptyData = true
//            //            self.reloadEmptyDataSet()
//            self.handlerDidFinishRequest?()
        }).handlerofflineLoad(handler: {

            self.emptyDataSet(headerHeight: self.headerHeight, image: self.emptyImage, title: self.emptyTitle, subTitle: "self.emptySubTitle", titleFont: .poppinsMedium17, subTitleFont: .poppinsMedium13)
            //                self.control.endRefreshing()
            //                self.isShowEmptyData = true
            //                //                self.reloadEmptyDataSet()
            //                self.handlerDidFinishRequest?()

        })
//        _ = request?.getFunc(pageNumber: self.pageNumber, isShowLoader: isShowLoader, scrollView: self, handlerResponse: { objects, totalPages, pageNumber, headerObject in
//            if isAdd {
//                self.objects += objects
//            } else {
//                self.objects = objects
//            }
//            self.totalPages = totalPages
//            self.pageNumber = pageNumber
//            self.headerObject = headerObject
//            debugPrint("objects =>> \(self.objects.count) || totalPages =>> \(totalPages) pageNumber =>> \(pageNumber)")
//        }, handlerOfflineLoad: {
//                self.control.endRefreshing()
//                self.isShowEmptyData = true
////                self.reloadEmptyDataSet()
//                self.handlerDidFinishRequest?()
//            })?.handlerDidFinishRequest {
//            self.control.endRefreshing()
//            self.isShowEmptyData = true
////            self.reloadEmptyDataSet()
//            self.handlerDidFinishRequest?()
//        }
    }
}

extension GeneralTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.objects.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: GeneralTableViewCell = tableView._dequeueReusableCell(withIdentifier: cell._id)
        cell.index = indexPath.item
        cell.object = self.objects[indexPath.item]
        cell.configureCell()
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? GeneralTableViewCell {
            cell.didselect(tableView, didSelectRowAt: indexPath)
        }
    }

    // MARK: Header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header: GeneralTableViewHeaderFooterView = tableView._dequeueReusableHeaderFooterView(withIdentifier: hedaer._id)
        header.object = self.headerObject
        header.configureHeader()
        return header
    }

}

extension GeneralTableView {
//
//    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView) -> Bool {
//        return isShowEmptyData
//    }
//
//    func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView) -> Bool {
//        return true
//    }
//
//    func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
//        return self.emptyImage
//    }
//
//    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
//        return NSAttributedString.init(string: self.titleEmpty, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .bold), .foregroundColor: UIColor.lightGray.withAlphaComponent(0.5)])
//    }
//
//    func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
//        return NSAttributedString.init(string: self.subTitleEmpty, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12, weight: .regular), .foregroundColor: UIColor.lightGray.withAlphaComponent(0.4)])
//    }
//
//    func verticalOffset(forEmptyDataSet scrollView: UIScrollView) -> CGFloat {
//        return verticalOffset
//    }
//
}
