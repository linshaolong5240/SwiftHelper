//
//  SHCarouselView.swift
//  SwiftHelper (iOS)
//
//  Created by sauron on 2022/1/27.
//

import SwiftUI
import SnapKit

public protocol SHCarouselViewDelegate: AnyObject {
    func carouselView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int)  -> Int
    func carouselView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    func carouselView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
}

public class SHCarouselView: UIView {
    public var autoCarousel: Bool = true
    private var timeInterval: TimeInterval { didSet { resetTimer() } }
    private var scrollDirection: UICollectionView.ScrollDirection = .horizontal
    private var currentPage: Int = 0
    private let layout = UICollectionViewFlowLayout()
    private(set) var collectionView: UICollectionView!
    private(set) var pageControl = UIPageControl()
    private(set) var cyclePage: Int = 1
    private var cycleIndex: [Int] = [Int]()
    weak var delegate: SHCarouselViewDelegate?
    
    private var timer: Timer?
    
    init(frame: CGRect = .zero, scrollDirection: UICollectionView.ScrollDirection = .horizontal, showPageIndicator: Bool = true, timeInterval: TimeInterval = 3.25) {
        self.scrollDirection = scrollDirection
        self.timeInterval = timeInterval
        super.init(frame: frame)
        configureCollectionView()
        if showPageIndicator {
            configurePageControl()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        timer?.invalidate()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        switch layout.scrollDirection {
        case .horizontal:
            collectionView.contentOffset.x = collectionView.bounds.width
        case .vertical:
            collectionView.contentOffset.y = collectionView.bounds.height
        @unknown default: break
        }
    }
    
    private func configureCollectionView() {
        layout.scrollDirection = scrollDirection
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.bounces = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func configurePageControl() {
        pageControl.currentPage = currentPage
        pageControl.addTarget(self, action: #selector(pageControlOnClicked), for: .valueChanged)
        addSubview(pageControl)
        switch scrollDirection {
        case .horizontal:
            pageControl.snp.makeConstraints { make in
                make.left.right.bottom.equalToSuperview()
            }
        case .vertical:
            let angle = CGFloat.pi/2
            pageControl.transform = CGAffineTransform(rotationAngle: angle)
            pageControl.snp.makeConstraints { make in
                make.top.bottom.equalToSuperview()
                make.centerX.equalTo(snp.right).offset(-10)
            }
        @unknown default: break
        }

    }
    
    func register(_ cellClass: AnyClass?, forCellWithReuseIdentifier identifier: String) {
        collectionView.register(cellClass, forCellWithReuseIdentifier: identifier)
    }
    
    func reloadData() {
        collectionView.reloadData()
    }
    
    private func resetTimer(stop: Bool = false) {
        timer?.invalidate()
        guard autoCarousel == true, stop == false else { return }
        timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) {[weak self] timer in
            self?.nextPage()
        }
    }
    
    private func scrollToPage(page: Int, animated: Bool) {
        switch scrollDirection {
        case .horizontal:
            let point = CGPoint(x: CGFloat(page) * collectionView.bounds.width, y: collectionView.contentOffset.y)
            collectionView.setContentOffset(point, animated: animated)
        case .vertical:
            let point = CGPoint(x: collectionView.contentOffset.x, y: CGFloat(page) * collectionView.bounds.height)
            collectionView.setContentOffset(point, animated: animated)
        @unknown default: break
        }
    }
    
    private func nextPage() {
        cyclePage = (cyclePage + 1) % cycleIndex.count
        scrollToPage(page: cyclePage, animated: true)
    }
    
    private func cycleScroll() {
        guard cycleIndex.count > 0 else { return }
        currentPage = cycleIndex[cyclePage]
        pageControl.currentPage = currentPage
        #if false
        print("cyclePage:\(cyclePage) currentPage:\(currentPage)")
        #endif
        if cyclePage == 0 {
            cyclePage = cycleIndex.count - 2
            scrollToPage(page: cyclePage, animated: false)
        }
        if cyclePage == cycleIndex.count - 1 {
            cyclePage = 1
            scrollToPage(page: cyclePage, animated: false)
        }
    }
    
    @objc private func pageControlOnClicked(sender: UIPageControl, forEvent event: UIEvent) {
        resetTimer()
        currentPage = sender.currentPage
        cyclePage = currentPage + 1
        scrollToPage(page: cyclePage, animated: true)
    }
}

extension SHCarouselView: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let num = delegate?.carouselView(collectionView, numberOfItemsInSection: section), num > 0 else { return 0 }
        let indexs = Array(0...num-1)
        let first = indexs.first!
        let last = indexs.last!
        cycleIndex = [last] + indexs + [first]
        if num > 1 {
            resetTimer()
            pageControl.numberOfPages = num
            collectionView.isScrollEnabled =  true
            return cycleIndex.count
        } else {
            resetTimer(stop: true)
            pageControl.numberOfPages = 0
            collectionView.isScrollEnabled =  false
            return num
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = delegate?.carouselView(collectionView, cellForItemAt: .init(row: cycleIndex[indexPath.row], section: indexPath.section)) else {
            return UICollectionViewCell()
        }
        
        return cell
    }
}

extension SHCarouselView: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        collectionView.frame.size
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.carouselView(collectionView, didSelectItemAt: .init(row: currentPage, section: indexPath.section))
    }
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//        print("scrollViewWillBeginDragging")
        timer?.invalidate()
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        print("scrollViewDidEndDecelerating")
        //手指拖动后
        switch scrollDirection {
        case .horizontal:
            cyclePage = Int(collectionView.contentOffset.x /  collectionView.bounds.width)
        case .vertical:
            cyclePage = Int(collectionView.contentOffset.y /  collectionView.bounds.height)
        @unknown default: break
        }
        cycleScroll()
        resetTimer()
    }
    
    public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
//        print("scrollViewDidEndScrollingAnimation")
        cycleScroll()
    }
}

extension SHCarouselView: SHCarouselViewDelegate {
    public func carouselView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SHCarouselViewDemoCell.reusedIdentifier, for: indexPath) as? SHCarouselViewDemoCell
        let colors: [UIColor] = [.blue, .purple, .green]
        cell?.backgroundColor = colors[indexPath.row % colors.count]

        return cell ?? UICollectionViewCell()

    }
    
    public func carouselView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    public func carouselView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
}

class SHCarouselViewDemoCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

struct CarouselViewDemoView: View {
    var body: some View {
        ZStack {
            Color.pink
            VStack {
                let v = SHCarouselView()
                PlatformViewRepresent(v)
                    .frame(height: 160)
                    .onAppear(perform: {
                        v.register(SHCarouselViewDemoCell.self, forCellWithReuseIdentifier: SHCarouselViewDemoCell.reusedIdentifier)
                        v.delegate = v
                    })
                
                let v2 = SHCarouselView(scrollDirection: .vertical, showPageIndicator: true)
                PlatformViewRepresent(v2)
                    .frame(height: 160)
                    .onAppear(perform: {
                        v2.register(SHCarouselViewDemoCell.self, forCellWithReuseIdentifier: SHCarouselViewDemoCell.reusedIdentifier)
                        v2.delegate = v2
                    })
            }
        }.ignoresSafeArea()
    }
}

#if DEBUG
struct CarouselView_Previews: PreviewProvider {
    static var previews: some View {
        CarouselViewDemoView()
    }
}
#endif
