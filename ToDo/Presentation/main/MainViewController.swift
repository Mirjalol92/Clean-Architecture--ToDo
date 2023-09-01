//
//  ViewController.swift
//  ToDo
//
//  Created by Ali on 2022/11/12.
//

import UIKit
import Material

class MainViewController: UITableViewController, UISearchBarDelegate{
    
    @InjetViewModel
    var viewModel: MainViewModel?
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewWillAppear(_ animated: Bool) {
        self.viewModel?.getToDoList()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setLayout()
        searchBar.delegate = self
        setNavBarItem(isDone: true)
        setObservers()
    }
    
    private func setLayout(){
        self.title = self.viewModel?.todayInString()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Delete", style: .plain, target: self, action: #selector(selectToDelete))
    }
    
    //MARK: - Observers
    func setObservers(){
        viewModel?.toDoList.bind{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            self.viewModel?.setEditToDo(nil)
            print($0)
        }
        
        viewModel?.leftBarItemState.bind { isDone in
            self.setNavBarItem(isDone: isDone)
        }
    }
    
    //MARK: - NavBarItems
    private func setNavBarItem(isDone: Bool){
        if isDone{
            self.navigationItem.leftBarButtonItem?.style = .plain
            self.navigationItem.leftBarButtonItem?.title = "Delete"
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addClicked(_:)))
            self.navigationItem.rightBarButtonItem?.tag = 2
        }else{
            self.navigationItem.leftBarButtonItem?.style = .done
            self.navigationItem.leftBarButtonItem?.title = "Cancel"
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(self.addClicked(_:)))
            self.navigationItem.rightBarButtonItem?.tag = 1
        }
    }
    
    //MARK: - Click Actions
    @objc func addClicked(_ barItem: UIBarButtonItem){
        if barItem.tag == 1{
            self.viewModel?.deletedSelected(){ msg in
                print(msg)
            }
        }else{
            self.performSegue(withIdentifier: "navigateToEdit", sender: self)
        }
    }
    
    @objc func selectToDelete(){
        viewModel?.setLeftBarItemState(isDone: navigationItem.leftBarButtonItem?.style == .done)
    }
    
    func setTableView(){
        tableView.allowsSelection = true
        tableView.register(UINib.init(nibName: "ToDoCell", bundle: nil), forCellReuseIdentifier:"idToDoCell")
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel?.filterToDoList(by: searchText.trimmed)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.getCountOfToDoList() ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "idToDoCell") as! ToDoCell
        if let data = viewModel?.getToDoItem(index: indexPath.row){
            cell.setData(
                data: data,
                seeMore: {
                    self.viewModel!.setEditToDo(data)
                    self.performSegue(withIdentifier: "navigateToEdit", sender: self)
                },checked: { checkded in
    //                data.isCompleted = checkded
                    self.viewModel?.addToDeleteList(todo: data)
                }
            )
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            viewModel?.delete(at: indexPath.row)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "navigateToEdit"{
            let vc = segue.destination as! EditViewController
            vc.comingData = viewModel?.getEditToDo()
        }
    }
}

