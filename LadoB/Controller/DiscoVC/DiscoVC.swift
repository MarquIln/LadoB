import UIKit

class DiscoVC: UIViewController {
    var allAlbums = Persistence.getAllAlbuns()
    var discoAlbuns: [Album] = []
    var groupedAlbums: [String: [Album]] = [:]
    var sectionTitles: [String] = []

    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CardTableViewCell.self, forCellReuseIdentifier: CardTableViewCell.reuseIdentifier)
        tableView.backgroundColor = .purple2
        tableView.contentInsetAdjustmentBehavior = .automatic
        return tableView
    }()

    let emptyState: EmptyState = {
        let view = EmptyState()
        view.titleText = "Nenhum LP salvo ainda"
        view.descriptionText = "Os álbuns, coletâneas e listas cadastradas e criadas por você aparecerão aqui"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let searchController = UISearchController(searchResultsController: nil)

    lazy var addButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            image: UIImage(systemName: "plus.circle.fill"),
            style: .plain,
            target: self,
            action: #selector(addTapped)
        )
        button.tintColor = .yellow1
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        discoAlbuns = Persistence.getDiscoAlbuns()
        tableView.reloadData()
        setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let updatedDiscoAlbuns = Persistence.getDiscoAlbuns()
        groupAndSortAlbums(updatedDiscoAlbuns)
        updateAddButtonIcon()
    }


    func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Álbum, Artista, Banda, Gênero"
        searchController.searchBar.searchTextField.font = Fonts.bodyBold
        searchController.searchBar.autocapitalizationType = .none
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    func configureLayout() {
        view.addSubview(tableView)
        view.addSubview(emptyState)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            
            emptyState.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            emptyState.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            emptyState.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }

    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }

    func updateAddButtonIcon() {
        let iconName = allAlbums.isEmpty ? "plus.circle.fill" : "heart.fill"
        addButton.image = UIImage(systemName: iconName)
    }

    @objc func addTapped() {
        if !allAlbums.isEmpty {
            let favoriteVC = FavoritesVC()
            navigationController?.pushViewController(favoriteVC, animated: true)
            return
        }
        navigationController?.pushViewController(SearchVC(), animated: true)
    }

    func loadAlbums() {
        guard let url = Bundle.main.url(forResource: "mockedData", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let decoded = try? JSONDecoder().decode([Album].self, from: data) else {
            return
        }

        discoAlbuns = decoded.filter {Persistence.isOnDiscoList($0)}
        
//        Persistence.saveToDisco(allAlbums[54])
//        Persistence.saveToDisco(allAlbums[89])
//        Persistence.saveToDisco(allAlbums[8])
//        Persistence.saveToDisco(allAlbums[21])
//        Persistence.saveToDisco(allAlbums[77])
        
        groupAndSortAlbums(Persistence.getDiscoAlbuns())
        tableView.reloadData()
    }

    func updateAlbums(_ albums: [Album]) {
        groupAndSortAlbums(Persistence.getDiscoAlbuns())
        tableView.reloadData()
    }
    
//    func getAlbum(by indexPath: IndexPath) -> Album {
//        let albumOfSection = groupedAlbums[indexPath.section]
//        let album = albumOfSection[indexPath.row]
//        return album
//    }

    private func groupAndSortAlbums(_ albums: [Album]) {
        let sorted = albums.sorted { $0.title.localizedCaseInsensitiveCompare($1.title) == .orderedAscending }
        groupedAlbums = Dictionary(grouping: sorted) { String($0.title.prefix(1)).uppercased() }
        sectionTitles = groupedAlbums.keys.sorted()
        emptyState.isHidden = !albums.isEmpty
        tableView.isHidden = albums.isEmpty
        tableView.reloadData()
    }
}
