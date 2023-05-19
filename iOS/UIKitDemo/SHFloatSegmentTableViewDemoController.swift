//
//  SHFloatSegmentTableViewDemoController.swift
//  SwiftHelper (iOS)
//
//  Created by sauron on 2022/5/30.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import SwiftUI
import SnapKit
import JXSegmentedView

class SHFloatSegmentTableViewDemoController: UIViewController {
    private var container: UIView!
    private var tableView: UITableView!
    private var segmentedView: JXSegmentedView!
    private var segmentedDataSource: JXSegmentedTitleDataSource!
    private let segmentedViewJeight: CGFloat = 80
    
    private let items = Array<Int>(0..<30)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .systemPink
        configureContainer()
        coonfigureJxSegmentView()
        configureTableView()
    }
    
    func configureContainer() {
        container = UIView()
        container.backgroundColor = .purple
        view.addSubview(container)
        container.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.left.right.equalToSuperview()
        }
    }
    
    func coonfigureJxSegmentView() {
        segmentedView = JXSegmentedView()
        segmentedView.backgroundColor = .orange
        segmentedView.delegate = self
        
        segmentedDataSource = JXSegmentedTitleDataSource()
        segmentedDataSource.titles = items.map({ "title \($0)" })
        segmentedDataSource.titleSelectedColor = .systemPink
        segmentedDataSource.titleNormalColor = .black
        segmentedDataSource.titleNormalFont = .systemFont(ofSize: 13)
        segmentedDataSource.titleSelectedFont = .systemFont(ofSize: 13, weight: .bold)

        segmentedView.dataSource = segmentedDataSource
        
        let indicator = JXSegmentedIndicatorBackgroundView()
        indicator.clipsToBounds = true
        indicator.indicatorHeight = 30
        let gradientView = JXSegmentedComponetGradientView()
        gradientView.gradientLayer.startPoint = CGPoint(x: 0, y: 1)
        gradientView.gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientView.gradientLayer.colors = [#colorLiteral(red: 0.3069871068, green: 0.8298507333, blue: 0.9859995246, alpha: 1), #colorLiteral(red: 0.9482335448, green: 0.3878634572, blue: 0.9913905263, alpha: 1), #colorLiteral(red: 0.9963704944, green: 0.6931408048, blue: 0.2031244636, alpha: 1)].map({ $0.cgColor })
        //设置gradientView布局和JXSegmentedIndicatorBackgroundView一样
        gradientView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        indicator.addSubview(gradientView)
        segmentedView.indicators = [indicator]
    }
    
    func configureTableView() {
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .systemPink
//        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.contentInset = .init(top: 0, left: 0, bottom: 200, right: 0)
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        let headview = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 100))
        headview.backgroundColor = .blue
        tableView.tableHeaderView = headview
        tableView.register(UITableViewDemoCell.self, forCellReuseIdentifier: UITableViewDemoCell.reusedIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        container.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

#if DEBUG
struct FloatSegmentTableViewDemoController_Previews: PreviewProvider {
    static var previews: some View {
        PlatformViewControllerRepresent(SHFloatSegmentTableViewDemoController()).ignoresSafeArea()
    }
}
#endif

extension SHFloatSegmentTableViewDemoController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewDemoCell.reusedIdentifier, for: indexPath)
        cell.textLabel?.text = "cell \(indexPath.row)"
        return cell
    }
}

extension SHFloatSegmentTableViewDemoController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        segmentedView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        segmentedViewJeight
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        500
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        updateSegment()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        updateSegment()
    }
    
    func updateSegment() {
        guard !tableView.visibleCells.isEmpty else {
            segmentedView.selectItemAt(index: 0)
            return
        }
        let firstVisibleIndexPath = tableView.indexPathsForVisibleRows?[0]
        var index = firstVisibleIndexPath?.row ?? 0
        var rect = tableView.rectForRow(at: IndexPath(row: index, section: 0))
        rect = tableView.convert(rect, to: tableView.superview)
        if (rect.maxY - segmentedViewJeight) < 20 {
            index += 1
        }
        segmentedView.selectItemAt(index: index)
    }
}

extension SHFloatSegmentTableViewDemoController: JXSegmentedViewDelegate {
    func segmentedView(_ segmentedView: JXSegmentedView, didClickSelectedItemAt index: Int) {
        tableView.scrollToRow(at: .init(row: index, section: 0), at: .top, animated: true)
    }
}
