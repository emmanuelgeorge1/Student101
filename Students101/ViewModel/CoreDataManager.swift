//
//  CoreDataManager.swift
//  Students101
//
//  Created by Emmanuel George on 16/09/22.
//

import Foundation
import CoreData
import UIKit

class CoreDataServices:NSObject{
    static let shared = CoreDataServices()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func getStudentsList()->[StudentInfo]{
        var students = [StudentInfo]()
        let request : NSFetchRequest <StudentInfo> = StudentInfo.fetchRequest()
        do{
            students = try context.fetch(request)
            
        }catch{
            print("Error while fetching data from DB \(error)")
        }
        return students
    }
    func searchStudents(searchText:String)->[StudentInfo]{
        var students = [StudentInfo]()
        let predicate = NSPredicate(format: "firstName CONTAINS[cd] %@", searchText)
        let predicate2 = NSPredicate(format: "course CONTAINS[cd] %@", searchText)
        let request:NSFetchRequest = StudentInfo.fetchRequest()
        let compoundPredicate = NSCompoundPredicate.init(orPredicateWithSubpredicates: [predicate, predicate2])
        request.predicate = compoundPredicate
        do {
            students = try context.fetch(request)
        } catch {
            print("Error while fetching data from DB \(error)")
        }
        return students
    }
    func deleteStudentData(index:Int)->[StudentInfo]{
        var students = getStudentsList()
        context.delete(students[index])
        students.remove(at:index)
        do {
            try self.context.save()
        } catch let error as NSError {
            print("Error While Deleting student: \(error.localizedDescription)")
        }
        return students
    }
    
    func saveStudentData(studentDict:[String:Any]){
        let student = NSEntityDescription.insertNewObject(forEntityName: "StudentInfo", into: context) as! StudentInfo
        student.firstName = studentDict["firstName"] as? String
        student.lastName = studentDict["lastName"] as? String
        student.email = studentDict["email"] as? String
        student.phone = studentDict["phone"] as? String
        student.course = studentDict["course"] as? String
        student.dob = studentDict["dob"] as? Date
        student.adress = studentDict["adress"] as? String
        student.blood = studentDict["blood"] as? String
        do{
            try context.save()
            print("success")
            
        }catch{
            print("Error saving context\(error.localizedDescription)")
        }
    }
    func editStudentData(studentDict:[String:Any],index:Int){
        let students = getStudentsList()
        students[index].firstName = studentDict["firstName"] as? String
        students[index].lastName = studentDict["lastName"] as? String
        students[index].email = studentDict["email"] as? String
        students[index].phone = studentDict["phone"] as? String
        students[index].course = studentDict["course"] as? String
        students[index].dob = studentDict["dob"] as? Date
        students[index].adress = studentDict["adress"] as? String
        students[index].blood = studentDict["blood"] as? String
        do{
            try context.save()
            print("success")
            
        }catch{
            print("Error editing student data\(error.localizedDescription)")
        }
    }
}
