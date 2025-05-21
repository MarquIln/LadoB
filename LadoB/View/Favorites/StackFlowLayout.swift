//
//  StackFlowLayout.swift
//  LadoB
//
//  Created by Marcos on 20/05/25.
//

import UIKit

class StackFlowLayout: UICollectionViewFlowLayout {
    let baseSize = CGSize(width: 346, height: 346)
    let itemSpacing: CGFloat = -100
    let shrinkStep: CGFloat = 16

    override init() {
        super.init()
        scrollDirection = .vertical
        minimumLineSpacing = itemSpacing
        itemSize = baseSize
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func adjustedAttributes(
        from attributes: UICollectionViewLayoutAttributes,
        totalItems: Int,
        in collectionView: UICollectionView
    ) -> UICollectionViewLayoutAttributes? {
        guard
            let copied = attributes.copy() as? UICollectionViewLayoutAttributes
        else {
            return nil
        }

        let itemIndex = copied.indexPath.item
        let reverseIndex = (totalItems - 1) - itemIndex
        let shrinkOffset = CGFloat(reverseIndex) * shrinkStep

        let resizedWidth = max(baseSize.width - shrinkOffset, 0)
        let resizedHeight = max(baseSize.height - shrinkOffset, 0)
        copied.size = CGSize(width: resizedWidth, height: resizedHeight)

        let centeredX = (collectionView.bounds.width - resizedWidth) / 2
        copied.frame.origin.x = centeredX
        copied.zIndex = 1000 - reverseIndex

        return copied
    }

    override func layoutAttributesForElements(in rect: CGRect)
        -> [UICollectionViewLayoutAttributes]?
    {
        guard
            let defaultAttributes = super.layoutAttributesForElements(in: rect),
            let collectionView = collectionView
        else {
            return nil
        }

        let totalItems = collectionView.numberOfItems(inSection: 0)

        return defaultAttributes.compactMap { originalAttributes in
            return adjustedAttributes(
                from: originalAttributes,
                totalItems: totalItems,
                in: collectionView
            )
        }
    }
}
