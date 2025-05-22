//
//  SearchVC+Layouts.swift
//  LadoB
//
//  Created by Carolina Silva dos Santos on 15/05/25.
//

import UIKit

extension SearchVC {
    
    func createSmallItemLayout() -> NSCollectionLayoutSection {
            
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .absolute(126),
            heightDimension: .absolute(163)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .estimated(126),
            heightDimension: .absolute(163)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(10)

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 8.0
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 16, trailing: 16)
        section.boundarySupplementaryItems = [createSectionHeader()]
        
        return section
    }
    
    func createLargeItemLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .estimated(174),
            heightDimension: .absolute(272)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(10)

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 8.0
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 16, trailing: 16)
        section.boundarySupplementaryItems = [createSectionHeader()]
        
        return section
    }
    
    func createAllLayout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            if sectionIndex == 0 {
                return self.createSmallItemLayout()
            } else {
                return self.createLargeItemLayout()
            }
        }
        
        return layout
    }
    
    private func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
           return NSCollectionLayoutBoundarySupplementaryItem(
               layoutSize: NSCollectionLayoutSize(
                   widthDimension: .fractionalWidth(1.0),
                   heightDimension: .absolute(40)
               ),
               elementKind: UICollectionView.elementKindSectionHeader,
               alignment: .topLeading
           )
       }
    
}

extension SearchResultsVC {
    
    func filterItemLayout() -> NSCollectionLayoutSection {
            
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .absolute(126),
            heightDimension: .absolute(163)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .estimated(126),
            heightDimension: .absolute(163)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(10)

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 8.0
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 16, trailing: 16)
        
        return section
    }
    
    func smallItemGridLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .absolute(106),
            heightDimension: .absolute(144)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .estimated(106),
            heightDimension: .absolute(144)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item, item, item]
        )
        
        group.interItemSpacing = .fixed(26)

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none
        section.interGroupSpacing = 10.0
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 16, trailing: 16)
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(48)
        )

        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        header.pinToVisibleBounds = true

        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    func createResultsLayout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            if sectionIndex == 0 {
                return self.smallItemGridLayout()
            } else {
                return self.smallItemGridLayout()
            }
        }
        
        return layout
    }
    
}

