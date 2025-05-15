//
//  SearchResultHeader.swift
//  AppStoreClone
//
//  Created by 곽다은 on 5/14/25.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxRelay

final class SearchResultHeader: UICollectionReusableView {

    // MARK: - Properties

    let didTapTitle = PublishRelay<Void>()
    var disposeBag = DisposeBag()

    // MARK: - UIComponents

    private let titleLabel = UILabel().then {
        $0.textColor = .label
        $0.font = .systemFont(ofSize: 36, weight: .bold)
        $0.isUserInteractionEnabled = true
    }

    // MARK: - Init, Deinit, required

    override init(frame: CGRect) {
        super.init(frame: frame)
        setHierarchy()
        setConstraints()
        bind()
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

    override func prepareForReuse() {
        super.prepareForReuse()
        updateHeader(nil)
        disposeBag = DisposeBag()
        bind()
    }

    // MARK: - Constraints Helper

    private func setConstraints() {
        titleLabel.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(20)
            $0.directionalHorizontalEdges.equalToSuperview()
        }
    }

    // MARK: - Methods

    private func bind() {
        let tapGesture = UITapGestureRecognizer()
        titleLabel.addGestureRecognizer(tapGesture)

        tapGesture.rx.event
            .bind(onNext: { [weak self] _ in
                self?.didTapTitle.accept(())
            })
            .disposed(by: disposeBag)
    }

    func updateHeader(_ title: String?) {
        titleLabel.text = title
    }
}
