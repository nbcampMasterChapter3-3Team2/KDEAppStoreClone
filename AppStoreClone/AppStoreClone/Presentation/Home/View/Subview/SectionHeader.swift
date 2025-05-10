//
//  SectionHeader.swift
//  AppStoreClone
//
//  Created by 곽다은 on 5/11/25.
//

import UIKit
import SnapKit
import Then

final class SectionHeader: UICollectionReusableView {

    // MARK: - UIComponents

    private let titleLabel = UILabel().then {
        $0.textColor = .label
        $0.font = .systemFont(ofSize: 20, weight: .heavy)
    }

    private let descriptionLabel = UILabel().then {
        $0.textColor = .secondaryLabel
        $0.font = .systemFont(ofSize: 16, weight: .regular)
    }

    // MARK: - Init, Deinit, required

    override init(frame: CGRect) {
        super.init(frame: frame)
        setHierarchy()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Hierarchy Helper

    private func setHierarchy() {
        [
            titleLabel,
            descriptionLabel,
        ].forEach { addSubview($0) }
    }

    // MARK: - Constraints Helper

    private func setConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.directionalHorizontalEdges.equalToSuperview()
        }

        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.directionalHorizontalEdges.bottom.equalToSuperview()
        }
    }

    // MARK: - Methods

    func updateHeader(_ title: String, _ description: String) {
        titleLabel.text = title
        descriptionLabel.text = description
    }

}
