import UIKit

/// A custom UICollectionViewLayout implementing a waterfall (Pinterest-style) grid.
/// Items are placed in the shortest column, creating a staggered masonry effect.
final class WaterfallLayout: UICollectionViewLayout {

    var numberOfColumns: Int = 2
    var spacing: CGFloat = 12
    var sectionInsets: UIEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
    weak var delegate: WaterfallLayoutDelegate?

    private var cache: [UICollectionViewLayoutAttributes] = []
    private var contentHeight: CGFloat = 0

    private var contentWidth: CGFloat {
        guard let collectionView else { return 0 }
        return collectionView.bounds.width - sectionInsets.left - sectionInsets.right
    }

    override var collectionViewContentSize: CGSize {
        CGSize(width: contentWidth + sectionInsets.left + sectionInsets.right, height: contentHeight)
    }

    override func prepare() {
        guard let collectionView, cache.isEmpty else { return }

        let columnWidth = (contentWidth - spacing * CGFloat(numberOfColumns - 1)) / CGFloat(numberOfColumns)
        var columnOffsets = [CGFloat](repeating: sectionInsets.top, count: numberOfColumns)
        var xOffsets: [CGFloat] = []

        for column in 0..<numberOfColumns {
            xOffsets.append(sectionInsets.left + CGFloat(column) * (columnWidth + spacing))
        }

        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            let shortestColumn = columnOffsets.enumerated().min(by: { $0.element < $1.element })?.offset ?? 0
            let indexPath = IndexPath(item: item, section: 0)
            let itemHeight = delegate?.waterfallLayout(self, heightForItemAt: indexPath, width: columnWidth) ?? 150

            let frame = CGRect(x: xOffsets[shortestColumn], y: columnOffsets[shortestColumn],
                               width: columnWidth, height: itemHeight)

            let attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
            attributes.frame = frame
            cache.append(attributes)
            columnOffsets[shortestColumn] = frame.maxY + spacing
        }
        contentHeight = (columnOffsets.max() ?? 0) + sectionInsets.bottom
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        cache.filter { $0.frame.intersects(rect) }
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard indexPath.item < cache.count else { return nil }
        return cache[indexPath.item]
    }

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        guard let collectionView else { return false }
        return collectionView.bounds.width != newBounds.width
    }

    override func invalidateLayout() {
        super.invalidateLayout()
        cache.removeAll()
        contentHeight = 0
    }
}

/// Delegate protocol for providing item heights to the waterfall layout.
protocol WaterfallLayoutDelegate: AnyObject {
    func waterfallLayout(_ layout: WaterfallLayout, heightForItemAt indexPath: IndexPath, width: CGFloat) -> CGFloat
}
