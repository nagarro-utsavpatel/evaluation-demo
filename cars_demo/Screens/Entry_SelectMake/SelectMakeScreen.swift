//
//  SelectMakeScreen.swift
//  cars_demo
//
//  Created by Utsav Patel on 15/02/2022.
//

import UIKit

class SelectMakeScreen: UIViewController, Instantiable {
    // MARK: - implementation UI
    @IBOutlet private var makeListTable: UITableView!
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!

    var viewModel: MakeViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureProperties()
        configureLayout()
        configureReactiveBinding()
    }

    // MARK: 
    private func configureProperties() {
        navigationItem.title = "List of Makes"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .automatic
    }

    private func configureLayout() {
        makeListTable.contentInset.bottom = view.safeAreaInsets.bottom
        makeListTable.delegate = self
        makeListTable.dataSource = self
        makeListTable.separatorColor = UIColor.blue.withAlphaComponent(0.4)
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
                        self?.makeListTable.alpha = 0.0
                    })
                } else {
                    self?.activityIndicator.stopAnimating()
                    UIView.animate(withDuration: 0.2, animations: {
                        self?.makeListTable.alpha = 1.0
                    })
                }
            }
        }

        viewModel.reloadTableViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.makeListTable.reloadData()
            }
        }

        viewModel.initFetch()
    }

    func showAlert( _ message: String ) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension SelectMakeScreen: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "makeCell", for: indexPath) as? MakeCell else {
            return UITableViewCell()
        }
        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? MakeCell else {
            return
        }
        let cellVM = viewModel.getCellViewModel( at: indexPath )
        cell.setup(model: cellVM)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }

    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        self.viewModel.userPressed(at: indexPath)
        return indexPath
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
