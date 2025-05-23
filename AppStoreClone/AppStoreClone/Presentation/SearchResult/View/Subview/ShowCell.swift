//
//  ShowCell.swift
//  AppStoreClone
//
//  Created by 곽다은 on 5/14/25.
//

import UIKit
import SnapKit
import Then
import RxSwift

final class ShowCell: UICollectionViewCell {

    // MARK: - Properties

    private var imageLoadTask: Task<Void, Never>?
    private var disposeBag = DisposeBag()

    // MARK: - UI Components

    private let showKindLabel = UILabel().then {
        $0.textColor = .secondaryLabel
        $0.font = .systemFont(ofSize: 16, weight: .bold)
    }

    private let titleLabel = UILabel().then {
        $0.textColor = .label
        $0.font = .systemFont(ofSize: 22, weight: .bold)
    }

    private let artworkImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.backgroundColor = .quaternarySystemFill
    }

    // MARK: - Init, Deinit, requiered

    override init(frame: CGRect) {
        super.init(frame: frame)
        setStyle()
        setHierarchy()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: - Style Helper

    private func setStyle() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 10
    }

    // MARK: - Hierarchy Helper

    private func setHierarchy() {
        [
            showKindLabel,
            titleLabel,
            artworkImageView,
        ].forEach { contentView.addSubview($0) }
    }

    // MARK: - Constraints Helper

    private func setConstraints() {

        showKindLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.directionalHorizontalEdges.equalToSuperview().inset(20)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(showKindLabel.snp.bottom)
            $0.directionalHorizontalEdges.equalToSuperview().inset(20)
        }

        artworkImageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.directionalHorizontalEdges.bottom.equalToSuperview()
        }
    }

    // MARK: - Methods

    override func prepareForReuse() {
        super.prepareForReuse()
        imageLoadTask?.cancel()
        updateCell(with: nil, nil, nil, backgroundColor: .clear)
        disposeBag = DisposeBag()
    }

    func updateCell(with title: String?, _ showKind: String?, _ artworkImageURL: String?, backgroundColor: UIColor) {
        showKindLabel.text = showKind
        titleLabel.text = title
        contentView.backgroundColor = backgroundColor

        guard let artworkImageURL else { return }
        // TODO: Rx 사용
        imageLoadTask = Task {
            artworkImageView.image = await ImageLoader.shared.loadImage(from: artworkImageURL)
        }
    }
}
