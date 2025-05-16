//
//  MusicCompactCell.swift
//  AppStoreClone
//
//  Created by 곽다은 on 5/10/25.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

final class MusicCompactCell: UICollectionViewCell {

    // MARK: - Properties

    private var disposeBag = DisposeBag()

    // MARK: - UI Components

    private let artworkImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
        $0.backgroundColor = .quaternarySystemFill
    }

    private let stackView = UIStackView().then {
        $0.axis = .vertical
    }

    private let songTitleLabel = UILabel().then {
        $0.textColor = .label
        $0.font = .systemFont(ofSize: 16, weight: .bold)
    }

    private let artistLabel = UILabel().then {
        $0.textColor = .label
    }

    private let albumLabel = UILabel().then {
        $0.textColor = .secondaryLabel
        $0.font = .systemFont(ofSize: 12, weight: .regular)
    }

    private let lineView = UIView().then {
        $0.backgroundColor = .systemFill
    }

    // MARK: - Init, Deinit, requiered

    override init(frame: CGRect) {
        super.init(frame: frame)
        setHierarchy()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: - Hierarchy Helper

    private func setHierarchy() {
        [
            artworkImageView,
            stackView,
            lineView
        ].forEach { contentView.addSubview($0) }

        [
            songTitleLabel,
            artistLabel,
            albumLabel,
        ].forEach { stackView.addArrangedSubview($0) }
    }

    // MARK: - Constraints Helper

    private func setConstraints() {
        artworkImageView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(12)
            $0.leading.equalToSuperview()
            $0.size.equalTo(64)
        }

        stackView.snp.makeConstraints {
            $0.leading.equalTo(artworkImageView.snp.trailing).offset(16)
            $0.trailing.equalToSuperview()
            $0.centerY.equalTo(artworkImageView)
        }

        lineView.snp.makeConstraints {
            $0.directionalHorizontalEdges.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
    }

    // MARK: - Methods

    override func prepareForReuse() {
        super.prepareForReuse()
        updateCell(with: nil, nil, nil, nil)
        disposeBag = DisposeBag()
    }

    func updateCell(
        with title: String?,
        _ artist: String?,
        _ artworkImageURL: String?,
        _ album: String?
    ) {
        songTitleLabel.text = title
        artistLabel.text = artist
        albumLabel.text = album
        updateImageView(for: artworkImageURL)
    }

    private func updateImageView(for url: String?) {
        guard let url else {
            artworkImageView.image = nil
            return
        }
        ImageLoader.shared.loadImage(from: url)
            .asObservable()
            .asDriver(onErrorDriveWith: .empty())
            .drive(with: self) { owner, image in
                owner.artworkImageView.image = image
            }
            .disposed(by: disposeBag)
    }
}
