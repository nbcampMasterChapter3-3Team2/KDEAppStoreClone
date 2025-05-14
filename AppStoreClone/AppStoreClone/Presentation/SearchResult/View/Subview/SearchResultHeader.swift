//
//  SearchResultHeader.swift
//  AppStoreClone
//
//  Created by 곽다은 on 5/14/25.
//

import UIKit
import SnapKit
import Then

final class SearchResultHeader: UICollectionReusableView {

    // MARK: - UIComponents

    private let titleLabel = UILabel().then {
        $0.textColor = .label
        $0.font = .systemFont(ofSize: 36, weight: .bold)
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
        ].forEach { addSubview($0) }
    }

    // MARK: - Constraints Helper

    private func setConstraints() {
        titleLabel.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(20)
            $0.directionalHorizontalEdges.equalToSuperview()
        }
    }

    // MARK: - Methods

    func updateHeader(_ title: String) {
        titleLabel.text = title
    }
}
