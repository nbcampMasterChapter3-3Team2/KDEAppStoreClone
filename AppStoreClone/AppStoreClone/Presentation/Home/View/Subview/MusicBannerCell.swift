//
//  MusicBannerCell.swift
//  AppStoreClone
//
//  Created by 곽다은 on 5/10/25.
//

import UIKit
import SnapKit
import Then

final class MusicBannerCell: UICollectionViewCell {

    // MARK: - UI Components

    private let artworkImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }

    private let songTitleLabel = UILabel().then {
        $0.textColor = .label
        $0.font = .systemFont(ofSize: 16, weight: .bold)
    }

    private let artistLabel = UILabel().then {
        $0.textColor = .secondaryLabel
        $0.font = .systemFont(ofSize: 14, weight: .regular)
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
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.systemFill.cgColor
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 10
    }

    // MARK: - Hierarchy Helper

    private func setHierarchy() {
        [
            artworkImageView,
            songTitleLabel,
            artistLabel,
        ].forEach { contentView.addSubview($0) }
    }

    // MARK: - Constraints Helper

    private func setConstraints() {
        artworkImageView.snp.makeConstraints {
            $0.top.directionalHorizontalEdges.equalToSuperview()
            $0.bottom.equalTo(songTitleLabel.snp.top).offset(-20)
        }

        songTitleLabel.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalTo(artistLabel.snp.top)
        }

        artistLabel.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(20)
        }
    }

    // MARK: - Methods

    func updateCell(with title: String, _ artist: String, _ artworkImageURL: String) {
        // TODO: 앨범 이미지 로드
        artworkImageView.backgroundColor = .cyan.withAlphaComponent(0.3)
        songTitleLabel.text = title
        artistLabel.text = artist
    }
}
