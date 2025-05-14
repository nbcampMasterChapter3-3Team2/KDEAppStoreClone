//
//  SearchResultView.swift
//  AppStoreClone
//
//  Created by 곽다은 on 5/14/25.
//

import UIKit

final class SearchResultView: UIView {

    // MARK: - Properties

    private var dataSource: UICollectionViewDiffableDataSource<SearchResultSection, Show>?

    // MARK: - UI Components

    private lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: createCollectionViewLayout()
    ).then {
        $0.keyboardDismissMode = .onDrag
        $0.register(ShowCell.self,forCellWithReuseIdentifier: ShowCell.identifier)
        $0.register(
            SearchResultHeader.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: SearchResultHeader.identifier
        )
    }

    // MARK: - Init, Deinit, required

    override init(frame: CGRect) {
        super.init(frame: frame)
        setStyle()
        setHierarchy()
        setConstraints()
        setDataSource()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: - Style Helper

    private func setStyle() {
        backgroundColor = .systemBackground
    }

    // MARK: - Hierarchy Helper

    private func setHierarchy() {
        [
            collectionView,
        ].forEach { addSubview($0) }
    }

    // MARK: - Constraints Helper

    private func setConstraints() {
        collectionView.snp.makeConstraints {
            $0.directionalEdges.equalToSuperview()
        }
    }

    // MARK: - DataSource Helper

    private func setDataSource() {
        dataSource = .init(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, show in
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: ShowCell.identifier,
                    for: indexPath
                ) as! ShowCell

                let kind = show.kind == .movie ? "Movie" : "Podcast"
                cell.updateCell(with: show.title, kind, show.artworkImageURL, backgroundColor: show.color)

                return cell
            })

        dataSource?.supplementaryViewProvider = { collectionView, kind, indexPath in
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SearchResultHeader.identifier, for: indexPath) as! SearchResultHeader

            header.updateHeader("Hello")

            return header
        }

        var snapshot = NSDiffableDataSourceSnapshot<SearchResultSection, Show>()
        snapshot.appendSections(SearchResultSection.allCases)
        dataSource?.apply(snapshot)
    }

    // MARK: - Methods

    private func createCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _
            -> NSCollectionLayoutSection? in

            let section = SearchResultSection.allCases[sectionIndex]
            switch section {
            case .show:
                let headerSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .estimated(50)
                )
                let header = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: headerSize,
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .topLeading
                )

                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)

                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalWidth(1.1)
                )
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 32
                section.contentInsets = .init(top: 0, leading: 16, bottom: 40, trailing: 16)
                section.boundarySupplementaryItems = [header]

                return section
            }
        }
        return layout
    }

    func updateSnapshot(with items: [Show], toSection section: SearchResultSection) {
        guard var snapshot = dataSource?.snapshot(for: section) else { return }
        snapshot.deleteAll()
        snapshot.append(items)
        dataSource?.apply(snapshot, to: section)
    }
}

extension SearchResultView {
    enum SearchResultSection: CaseIterable, Hashable {
        case show
    }
}
