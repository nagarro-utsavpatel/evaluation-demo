//
//  ModelDetailsScreen.swift
//  cars_demo
//
//  Created by Utsav Patel on 16/02/2022.
//

import UIKit

class ModelDetailsScreen: UIViewController, Instantiable {
    // MARK: - implementation UI
    @IBOutlet private var detailsTable: UITableView!
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!

    var viewModel: ModelDetailsViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureProperties()
        configureLayout()
        configureReactiveBinding()
    }

    // MARK: 
    private func configureProperties() {
        detailsTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        navigationItem.title = viewModel.name
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .automatic
    }

    private func configureLayout() {
        detailsTable.contentInset.bottom = view.safeAreaInsets.bottom
        detailsTable.delegate = self
        detailsTable.dataSource = self
        detailsTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    private func configureReactiveBinding() {
        // Naive binding
        viewModel.showAlertClosure = { [weak self] () in
            DispatchQueue.main.async {
                if let message = self?.viewModel.alertMessage {
                    self?.showAlert( message )
                }
            }
        }

        viewModel.updateLoadingStatus = { [weak self] () in
            DispatchQueue.main.async {
                let isLoading = self?.viewModel.isLoading ?? false
                if isLoading {
                    self?.activityIndicator.startAnimating()
                    UIView.animate(withDuration: 0.2, animations: {
                        self?.detailsTable.alpha = 0.0
                    })
                } else {
                    self?.activityIndicator.stopAnimating()
                    UIView.animate(withDuration: 0.2, animations: {
                        self?.detailsTable.alpha = 1.0
                    })
                }
            }
        }

        viewModel.reloadTableViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.detailsTable.reloadData()
            }
        }

        viewModel.initFetch()
    }

    func showAlert( _ message: String ) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel) { [weak self] _ in
            self?.viewModel.backToMoldes()
        })
        self.present(alert, animated: true, completion: nil)
    }
}

extension ModelDetailsScreen: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "detailcell",
                                                       for: indexPath) as? DetailCell else {
            return UITableViewCell()
        }
        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? DetailCell else {
            return
        }
        let cellVM = viewModel.getCellViewModel(at: indexPath)
        cell.setup(model: cellVM)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240
    }

    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        self.viewModel.userPressed(at: indexPath)
        return indexPath
    }
}
