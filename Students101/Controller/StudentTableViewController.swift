//
//  StudentTableViewController.swift
//  Students101
//  Created by Emmanuel George on 10/09/22.
import UIKit
import SwipeCellKit

class StudentTableViewController: UITableViewController,SwipeTableViewCellDelegate,UISearchBarDelegate {
    var isSearchActive = false
    var students = [StudentInfo]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 112.0
        tableView.register(StudentTableViewCell.nib(), forCellReuseIdentifier: K.studentCellId)
        self.clearsSelectionOnViewWillAppear = false
        tableView.allowsSelection = false
        students =  CoreDataServices.shared.getStudentsList()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        students =  CoreDataServices.shared.getStudentsList()
    }
   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if students.count>0{
            self.tableView.backgroundView = nil
            self.tableView.separatorStyle = .singleLine
            return students.count
        }
        if isSearchActive{
            let emptyLabel = UILabel(frame: CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height))
            emptyLabel.text = "No search result found"
            emptyLabel.textAlignment = NSTextAlignment.center
            self.tableView.backgroundView = emptyLabel
            self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
            return 0
        }
        else if students.count == 0 {
            let emptyLabel = UILabel(frame: CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height))
            emptyLabel.text = "No students added"
            emptyLabel.textAlignment = NSTextAlignment.center
            self.tableView.backgroundView = emptyLabel
            self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
            return 0
        }
        return students.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
      
        let cell = tableView.dequeueReusableCell(withIdentifier: K.studentCellId, for: indexPath) as!  StudentTableViewCell
        cell.delegate = self
        let studentList = students[indexPath.row]
        cell.configure(with: K.ImageName.profilePic)
        let name =  "\(studentList.firstName ?? "nil") \(studentList.lastName ?? "nil")"
        cell.name.text = "Name: \(name )"
        cell.email.text = "Email: \(studentList.email ?? "null")"
        cell.phoneNum.text = "Phone: \(studentList.phone ?? "null")"
        cell.courseName.text = "Course: \(studentList.course ?? "null")"
        return cell
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            let alert = UIAlertController(title: "Delete Student Record", message: "Are you sure you want to delete this record ", preferredStyle: .alert)
            let Delete = UIAlertAction(title: "Delete", style: .destructive) { (action: UIAlertAction!) in
                self.students = CoreDataServices.shared.deleteStudentData(index: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            let cancel = UIAlertAction(title:"Cancel", style: .cancel) { (action: UIAlertAction!) in
                alert.dismiss(animated: true, completion: nil)
            }
            alert.addAction(Delete)
            alert.addAction(cancel)
            self.present(alert, animated: true)
        }
        let editAction = SwipeAction(style: .default, title: "Edit") { (rowAction, indexPath) in
            let studentVc = self.storyboard?.instantiateViewController(withIdentifier: K.newStudentStoryboardID) as! NewStudentViewController
            studentVc.isUpdate = true
            studentVc.indexRow = indexPath.row
            studentVc.student = self.students[indexPath.row]
            self.navigationController?.pushViewController(studentVc, animated: false)
        }
        
        // customize the action appearance
        editAction.backgroundColor = .systemTeal
        deleteAction.image = UIImage(systemName: K.ImageName.deleteIcon)
        editAction.image = UIImage(systemName: K.ImageName.editIcon)
        return [deleteAction,editAction]
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != ""{
            isSearchActive = false
            students = CoreDataServices.shared.searchStudents(searchText: searchText)
            isSearchActive = true
        }
        else{
            students =  CoreDataServices.shared.getStudentsList()
            isSearchActive = false
        }
        tableView.reloadData()
    }
}
