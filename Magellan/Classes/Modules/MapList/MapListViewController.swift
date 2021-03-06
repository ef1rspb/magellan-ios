/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import UIKit
import SoraUI
import SoraFoundation

final class MapListViewController: UIViewController {

    private struct Constants {
        static let cornerRadius: CGFloat = 10
    }
    
    let presenter: MapListPresenterProtocol
    private let style: MagellanStyleProtocol
    private let headerView = UIView()
    private let panView = UIView()
    private let searchField = UITextField()
    private let activityIndicator = UIActivityIndicatorView(style: .gray)
    private let searchContainer = UIView()
    private let tableView = UITableView()
    private var keyboardHandler = KeyboardHandler()
    private var errorView: UIView?
    
    private lazy var placeCellStyle: PlaceCell.Style = {
        PlaceCell.Style(nameFont: style.semiBold15,
                        nameColor: style.darkColor,
                        categoryFont: style.regular14,
                        categoryTextColor: style.grayColor)
    }()
    
    init(presenter: MapListPresenterProtocol, style: MagellanStyleProtocol) {
        self.presenter = presenter
        self.style = style
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Storyboards are incompatible with truth and beauty.")
    }
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = style.sectionsDeviderBGColor
        self.view = view
        
        view.layer.cornerRadius = Constants.cornerRadius
        view.layer.masksToBounds = true
        
        configureViews()
        layoutViews()
        configureKeyboardHandler()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    fileprivate func configureHeader() {
        headerView.backgroundColor = style.backgroundColor
        view.addSubview(headerView)
        
        panView.backgroundColor = style.dividerColor
        panView.layer.cornerRadius = MapConstants.panHeight / 2
        headerView.addSubview(panView)
        
        searchContainer.backgroundColor = style.sectionsDeviderBGColor
        searchContainer.layer.cornerRadius = style.sideOffset
        headerView.addSubview(searchContainer)
        
        searchField.addTarget(self, action: #selector(search(_:)), for: .editingChanged)
        searchField.textColor = style.darkColor
        searchField.font = style.regular14
        searchField.textAlignment = .left
        searchField.clearButtonMode = .whileEditing
        searchField.borderStyle = .none
        searchField.backgroundColor = .clear
        searchField.delegate = self
        searchContainer.addSubview(searchField)
        
        searchContainer.addSubview(activityIndicator)
    }
    
    private func configureViews() {
        configureHeader()
        
        tableView.register(PlaceCell.self, forCellReuseIdentifier: PlaceCell.reuseIdentifier)
        tableView.backgroundColor = style.backgroundColor
        tableView.dataSource = self as UITableViewDataSource
        tableView.delegate = self as UITableViewDelegate
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 1))
        view.addSubview(tableView)
    }
    
    private func layoutViews() {
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        headerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        headerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        panView.translatesAutoresizingMaskIntoConstraints = false
        panView.heightAnchor.constraint(equalToConstant: MapConstants.panHeight).isActive = true
        panView.widthAnchor.constraint(equalToConstant: style.panWidth).isActive = true
        panView.centerYAnchor.constraint(equalTo: headerView.topAnchor, constant: Constants.cornerRadius).isActive = true
        panView.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true
        
        searchContainer.translatesAutoresizingMaskIntoConstraints = false
        searchContainer.topAnchor.constraint(equalTo: headerView.topAnchor, constant: style.offset * 3).isActive = true
        searchContainer.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -style.offset * 3).isActive = true
        searchContainer.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: style.doubleOffset).isActive = true
        searchContainer.rightAnchor.constraint(equalTo: headerView.rightAnchor, constant: -style.doubleOffset).isActive = true

        searchField.translatesAutoresizingMaskIntoConstraints = false
        searchField.topAnchor.constraint(equalTo: searchContainer.topAnchor, constant: style.topOffset).isActive = true
        searchField.bottomAnchor.constraint(equalTo: searchContainer.bottomAnchor, constant: -style.topOffset).isActive = true
        searchField.leftAnchor.constraint(equalTo: searchContainer.leftAnchor, constant: style.doubleOffset).isActive = true
        searchField.rightAnchor.constraint(equalTo: searchContainer.rightAnchor, constant: -style.offset).isActive = true
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.rightAnchor.constraint(equalTo: searchField.rightAnchor, constant: -style.offset).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: searchField.centerYAnchor).isActive = true
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -1).isActive = true
        tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
    }
    
    private func configureKeyboardHandler() {
        keyboardHandler.animateOnFrameChange = { [weak self] frame in
            guard self?.view.window != nil else {
                return
            }
            let bottomInset = frame.origin.y < UIScreen.main.bounds.size.height - 1 ? frame.size.height : 0
            self?.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: bottomInset, right: 0)
        }
    }

    @objc private func search(_ textfield: UITextField) {
        presenter.search(with: textfield.text)
    }
    
}


extension MapListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PlaceCell.reuseIdentifier) as? PlaceCell else {
            fatalError("dequeted cell is not PlaceCell type")
        }
        
        cell.place = presenter.places[indexPath.row]
        cell.style = placeCellStyle
        
        return cell
    }
 
}


extension MapListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        presenter.showDetails(place: presenter.places[indexPath.row])
    }
    
}


extension MapListViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        presenter.expand()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        search(textField)
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
}


extension MapListViewController: MapListViewProtocol {
    
    func set(loading: Bool) {
        if loading && !searchField.isEditing {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
    
    func set(placeholder: String) {
        searchField.placeholder = placeholder
    }
    
    func reloadPlaces() {
        if isViewLoaded
            && view.window != nil {
            errorView?.removeFromSuperview()
            tableView.isHidden = false
            headerView.isHidden = false
            tableView.reloadData()
            view.setNeedsLayout()
        }
    }
}


extension MapListViewController: NavigationBarHiding {}
