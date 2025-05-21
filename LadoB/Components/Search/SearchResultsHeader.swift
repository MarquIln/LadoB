//
//  SearchResultsHeader.swift
//  LadoB
//
//  Created by Carolina Silva dos Santos on 20/05/25.
//

import UIKit

protocol SearchResultsHeaderViewDelegate: AnyObject {
    func didSelectFilter(_ filter: String)
    func didSelectSortOption(_ sortOption: String)
}

class SearchResultsHeaderView: UICollectionReusableView {
    static let identifier = "SearchResultsHeaderView"

    weak var delegate: SearchResultsHeaderViewDelegate?

    private let filters = ["Artistas", "Álbuns", "Gênero"]
    private var selectedFilter: String?
    private var filterButtons: [UIButton] = []

    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        stack.distribution = .fill
        stack.alignment = .leading
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -45),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
        
        setupButtons()
    }

    private func setupButtons() {
        let sortDropdown = createSortDropdownButton()
        stackView.addArrangedSubview(sortDropdown)

        let attribute: [NSAttributedString.Key: Any] = [
            .font: Fonts.bodyBold,
            .foregroundColor: UIColor.pink1
        ]
        
        for filter in filters {
            let attributedTitle = AttributedString(filter, attributes: AttributeContainer(attribute))
            
            var config = UIButton.Configuration.plain()
            config.attributedTitle = attributedTitle
            config.baseForegroundColor = .pink1
            config.contentInsets = NSDirectionalEdgeInsets(top: 6, leading: 8, bottom: 6, trailing: 8)
            config.background.backgroundColor = .pink5
            config.background.cornerRadius = 16

            let button = UIButton(configuration: config)
            button.tag = filters.firstIndex(of: filter) ?? 0
            button.addTarget(self, action: #selector(filterTapped(_:)), for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false
            
            let width = filter.size(withAttributes: [NSAttributedString.Key.font: Fonts.bodyBold]).width + 24.2
            
            NSLayoutConstraint.activate([
                button.widthAnchor.constraint(equalToConstant: width)
            ])

            filterButtons.append(button)
            stackView.addArrangedSubview(button)
        }
    }
      
    private func createSortDropdownButton() -> UIButton {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "slider.horizontal.3")
        config.baseForegroundColor = .pink1
        config.contentInsets = NSDirectionalEdgeInsets(top: 6, leading: 12, bottom: 6, trailing: 12)
        config.background.backgroundColor = .pink5
        config.background.cornerRadius = 16

        let button = UIButton(configuration: config)
        button.showsMenuAsPrimaryAction = true

        button.addAction(UIAction { [weak button] _ in
            guard let button = button else { return }
            var activeConfig = button.configuration
            activeConfig?.baseForegroundColor = .purple1
            activeConfig?.background.backgroundColor = .yellow1
            button.configuration = activeConfig
        }, for: .touchDown)

        let menuItems = [
            UIAction(title: "De A a Z", handler: { [weak self, weak button] _ in
                self?.delegate?.didSelectSortOption("A-Z")
                button?.resetDropdownButtonColors()
            }),
            UIAction(title: "De Z a A", handler: { [weak self, weak button] _ in
                self?.delegate?.didSelectSortOption("Z-A")
                button?.resetDropdownButtonColors()
            }),
            UIAction(title: "Por Ano", handler: { [weak self, weak button] _ in
                self?.delegate?.didSelectSortOption("Ano")
                button?.resetDropdownButtonColors()
            })
        ]

        button.menu = UIMenu(title: "Ordenar por", options: .displayInline, children: menuItems)

        return button
    }
    
    @objc private func filterTapped(_ sender: UIButton) {
        // BOTAO ANTERIOR
        for button in filterButtons {
            if button.titleLabel?.text == selectedFilter {
                let attribute: [NSAttributedString.Key: Any] = [
                    .font: Fonts.bodyBold,
                    .foregroundColor: UIColor.pink1
                ]
                
                let attributedTitle = AttributedString(selectedFilter ?? "", attributes: AttributeContainer(attribute))

                var config = button.configuration
                config?.attributedTitle = attributedTitle
                config?.background.backgroundColor = .pink5
                button.configuration = config
            }
        }
        
        // BOTAO CLICADO NOVO
        let attribute: [NSAttributedString.Key: Any] = [
            .font: Fonts.bodyBold,
            .foregroundColor: UIColor.purple1
        ]
        
        let attributedTitle = AttributedString(sender.titleLabel?.text ?? "", attributes: AttributeContainer(attribute))

        var selectedConfig = sender.configuration
        selectedConfig?.background.backgroundColor = .yellow1
        selectedConfig?.attributedTitle = attributedTitle
        sender.configuration = selectedConfig

        let selected = filters[sender.tag]
        selectedFilter = selected
        delegate?.didSelectFilter(selected)
    }
}
private extension UIButton {
    func resetDropdownButtonColors() {
        var config = self.configuration
        config?.baseForegroundColor = .pink1
        config?.background.backgroundColor = .pink5
        self.configuration = config
    }
}
