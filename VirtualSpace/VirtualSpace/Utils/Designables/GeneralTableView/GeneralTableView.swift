// _________SKAIK_MO_________
//
//  GeneralTableView.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 22/07/2023.
//

import UIKit
import FirebaseFirestore

class GeneralTableView: UITableView {

    // MARK: - Table Properties
    var handlerDidFinishRequest: (() -> Void)?
    var objects: [Any] = [] {
        didSet {
            self.reloadData()
        }
    }
    var handleHeightCell: ((_ indexPath: IndexPath) -> CGFloat)?
    var handleCell: ((_ indexPath: IndexPath) -> UITableViewCell?)?
    var cell: UITableViewCell.Type = UITableViewCell.self {
        didSet {
            self._registerCell = cell.self
        }
    }

    private var headerObject: Any?
    var hedaer: UITableViewHeaderFooterView.Type = UITableViewHeaderFooterView.self {
        didSet {
            self._registerHeaderAndFooter = hedaer.self
        }
    }

    // MARK: - Empty Data Properties
    var emptyHeaderHeight: CGFloat = 0
    var emptyImage: UIImage?
    var emptyTitle = ""
    var emptySubTitle = ""

    // MARK: - PullToRefresh Properties
    private let control = UIRefreshControl.init()
    var isPullToRefreshEnable: Bool = false {
        didSet {
            if self.isPullToRefreshEnable {
                self.control.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
                self.refreshControl = control
            }
        }
    }

    // MARK: - LoadMore Properties
    var isLoadMoreEnable: Bool = false

    // MARK: - Request Properties
    private var lastDocument: QueryDocumentSnapshot?
    var request: GeneralController? = .none
    var isShowLoader: Bool = true

    override func awakeFromNib() {
        self.delegate = self
        self.dataSource = self
        self.separatorStyle = .none
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
        self.backgroundColor = .clear
        self.sectionHeaderHeight = 0
    }

}

// MARK: - Empty Data
extension GeneralTableView {
    func setEmptyData() {
        self.emptyDataSet(headerHeight: self.emptyHeaderHeight, image: self.emptyImage, title: self.emptyTitle, subTitle: self.emptySubTitle, titleFont: .poppinsMedium17, subTitleFont: .poppinsMedium13)
    }
}

// MARK: - PullToRefresh
extension GeneralTableView {

    @objc private func pullToRefresh() {
        self.resetTableView(request: self.request, isShowLoader: false)
    }

    func resetTableView(request: GeneralController?, isShowLoader: Bool = true) {
        self.isShowLoader = isShowLoader
        self.lastDocument = nil
        self.objects.removeAll()
        self.headerObject = nil
        self.sendRequest(request)
        self.isShowLoader = false
    }
}

// MARK: - Pagination (load more)
extension GeneralTableView {

    private func setPagination(_ indexPath: IndexPath) {
        guard self.isLoadMoreEnable, self.lastDocument != nil else { return }
        self.addLoading(indexPath) {
            self.sendRequest(self.request)
        }
    }
}

// MARK: - Request
extension GeneralTableView {
    private func sendRequest(_ request: GeneralController?) {
        self.request = request
        _ = request?.sendRequest(lastDocument: self.lastDocument, isShowLoader: isShowLoader, handlerResponse: { objects, lastDocument, headerObject in
            self.objects += objects
            self.lastDocument = lastDocument
            self.headerObject = headerObject
            debugPrint("objects =>> \(self.objects.count) || is lastDocuments nil =>> \(lastDocument == nil), headerObject =>> \(headerObject)")
        })?.handlerDidFinishRequest(handler: {
            self.setEmptyData()
            self.control.endRefreshing()
            self.stopLoading()
            self.handlerDidFinishRequest?()
        }).handlerofflineLoad(handler: {
            self.setEmptyData()
            self.control.endRefreshing()
            self.stopLoading()
            self.handlerDidFinishRequest?()

        })
    }
}

extension GeneralTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.objects.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = handleCell?(indexPath) {
            return cell
        }
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

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let height = handleHeightCell?(indexPath) {
            return height
        }
        return self.rowHeight
    }

    // MARK: Header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header: GeneralTableViewHeaderFooterView = tableView._dequeueReusableHeaderFooterView(withIdentifier: hedaer._id)
        header.object = self.headerObject
        header.configureHeader()
        return header
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.setPagination(indexPath)
    }

}
