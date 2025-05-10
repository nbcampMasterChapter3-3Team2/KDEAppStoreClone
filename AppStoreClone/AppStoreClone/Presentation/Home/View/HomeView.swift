//
//  HomeView.swift
//  AppStoreClone
//
//  Created by 곽다은 on 5/10/25.
//

import UIKit
import SnapKit
import Then

final class HomeView: UIView {

    // MARK: - Properties

    private var dataSource: UICollectionViewDiffableDataSource<Season, Song>?

    // MARK: - UI Components

    private lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: createCollectionViewLayout()
    ).then {
        $0.register(
            MusicBannerCell.self,
            forCellWithReuseIdentifier: MusicBannerCell.identifier
        )
        $0.register(
            MusicCompactCell.self,
            forCellWithReuseIdentifier: MusicCompactCell.identifier
        )
        $0.register(
            SectionHeader.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: SectionHeader.identifier
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
            $0.top.equalTo(safeAreaLayoutGuide).inset(16)
            $0.directionalHorizontalEdges.bottom.equalToSuperview()
        }
    }

    // MARK: - DataSource Helper

    private func setDataSource() {
        dataSource = .init(
            collectionView: collectionView,
            cellProvider: { [weak self] collectionView, indexPath, song in
                let section = Season.allCases[indexPath.section]
                switch section {
                case .spring: return self?.makeSpringCell(collectionView, indexPath, song)
                default: return self?.makeDefaultCell(collectionView, indexPath, song)
                }
            })

        dataSource?.supplementaryViewProvider = { collectionView, kind, indexPath in
            guard let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: SectionHeader.identifier,
                for: indexPath
            ) as? SectionHeader else { return nil }

            let section = Season.allCases[indexPath.section]
            header.updateHeader(section.sectionTitle, section.sectionDescription)

            return header
        }

        var snapshot = NSDiffableDataSourceSnapshot<Season, Song>()
        snapshot.appendSections(Season.allCases)
        dataSource?.apply(snapshot)
    }

    private func makeSpringCell(
        _ collectionView: UICollectionView,
        _ indexPath: IndexPath,
        _ song: Song
    ) -> UICollectionViewCell? {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MusicBannerCell.identifier,
            for: indexPath
        ) as? MusicBannerCell else { return nil }

        cell.updateCell(with: song.title, song.artist, song.artworkImageURL)

        return cell
    }

    private func makeDefaultCell(
        _ collectionView: UICollectionView,
        _ indexPath: IndexPath,
        _ song: Song
    ) -> UICollectionViewCell? {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MusicCompactCell.identifier,
            for: indexPath
        ) as? MusicCompactCell else { return nil }

        cell.updateCell(with: song.title, song.artist, song.artworkImageURL, song.album)

        return cell
    }

    // MARK: - Methods

    private func createCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, env
            -> NSCollectionLayoutSection? in
            guard let self else { return nil }

            let header = makeHeaderItemLayout()
            let section = Season.allCases[sectionIndex]
            let layoutSection: NSCollectionLayoutSection

            switch section {
            case .spring:
                layoutSection = makeSpringLayoutSection(env)
            default:
                layoutSection = makeDefaultLayoutSection()
            }
            layoutSection.boundarySupplementaryItems = [header]
            return layoutSection
        }
        return layout
    }

    private func makeHeaderItemLayout() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(50)
        )
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .topLeading
        )
        return header
    }

    private func makeSpringLayoutSection(_ environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let availableWidth = environment.container.contentSize.width
        let groupWidth = availableWidth * 0.84
        let groupHeight = groupWidth * 0.9

        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(groupWidth), heightDimension: .absolute(groupHeight))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.interGroupSpacing = 16
        section.contentInsets = .init(top: 10, leading: 16, bottom: 40, trailing: 16)

        return section
    }

    private func makeDefaultLayoutSection() -> NSCollectionLayoutSection {
        let cellHeight: CGFloat = 88
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(cellHeight))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.84), heightDimension: .estimated(cellHeight * 3))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, repeatingSubitem: item, count: 3)

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.interGroupSpacing = 16
        section.contentInsets = .init(top: 10, leading: 16, bottom: 40, trailing: 16)
        return section
    }
}
