import SwiftUI
import UIKit

/// SwiftUI wrapper for a UICollectionView with waterfall layout.
/// Bridges UIKit's custom collection view layout capabilities into SwiftUI.
struct WaterfallCollectionView<Item: Hashable, CellContent: View>: UIViewControllerRepresentable {
    let items: [Item]
    let columns: Int
    let spacing: CGFloat
    let itemHeight: (Item, CGFloat) -> CGFloat
    let cellContent: (Item) -> CellContent

    init(items: [Item], columns: Int = 2, spacing: CGFloat = 12,
         itemHeight: @escaping (Item, CGFloat) -> CGFloat,
         @ViewBuilder cellContent: @escaping (Item) -> CellContent) {
        self.items = items; self.columns = columns; self.spacing = spacing
        self.itemHeight = itemHeight; self.cellContent = cellContent
    }

    func makeUIViewController(context: Context) -> WaterfallViewController<Item, CellContent> {
        let vc = WaterfallViewController<Item, CellContent>()
        vc.columns = columns; vc.spacing = spacing
        vc.itemHeight = itemHeight; vc.cellContent = cellContent; vc.items = items
        return vc
    }

    func updateUIViewController(_ vc: WaterfallViewController<Item, CellContent>, context: Context) {
        vc.items = items
    }
}

final class WaterfallViewController<Item: Hashable, CellContent: View>: UIViewController,
    UICollectionViewDataSource, WaterfallLayoutDelegate {

    var items: [Item] = [] { didSet { collectionView?.reloadData() } }
    var columns: Int = 2
    var spacing: CGFloat = 12
    var itemHeight: ((Item, CGFloat) -> CGFloat)?
    var cellContent: ((Item) -> CellContent)?
    private var collectionView: UICollectionView?

    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = WaterfallLayout()
        layout.numberOfColumns = columns; layout.spacing = spacing; layout.delegate = self
        let cv = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        cv.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        cv.backgroundColor = .clear; cv.dataSource = self
        cv.register(HostingCell.self, forCellWithReuseIdentifier: "cell")
        view.addSubview(cv); collectionView = cv
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { items.count }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HostingCell
        if let content = cellContent?(items[indexPath.item]) { cell.configure(with: content) }
        return cell
    }

    func waterfallLayout(_ layout: WaterfallLayout, heightForItemAt indexPath: IndexPath, width: CGFloat) -> CGFloat {
        itemHeight?(items[indexPath.item], width) ?? 150
    }

    private class HostingCell: UICollectionViewCell {
        private var hostingController: UIHostingController<AnyView>?
        func configure<V: View>(with view: V) {
            if let hc = hostingController { hc.rootView = AnyView(view) } else {
                let hc = UIHostingController(rootView: AnyView(view))
                hc.view.backgroundColor = .clear
                hc.view.translatesAutoresizingMaskIntoConstraints = false
                contentView.addSubview(hc.view)
                NSLayoutConstraint.activate([
                    hc.view.topAnchor.constraint(equalTo: contentView.topAnchor),
                    hc.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                    hc.view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                    hc.view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                ])
                hostingController = hc
            }
        }
    }
}
