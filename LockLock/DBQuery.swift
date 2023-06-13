//
//  DBQuery.swift
//  LockLock
//
//  Created by Figo Alessandro Lehman on 22/03/23.
//

import SwiftUI
import Firebase

class DBQuery: ObservableObject{
    @Published var lockers: [[Locker]] = []
    @Published var curLockers: [[Locker]] = []
    @Published var tempLockers: [Locker] = []
    @Published var availLockers: [Int] = []
    @Published var users: [String] = []
    @Published var curUser: String = UIDevice.current.identifierForVendor!.uuidString
    
    init(){
//        initLockers()
        getLockers()
        getUsers()
        if !users.contains(curUser) {
            addCurUser()
        }
    }
    
    func getCurLocker(){
        tempLockers.removeAll()
        curLockers.removeAll()
        print(lockers)
        for locker in lockers[0]{
            if locker.userId == curUser{
                tempLockers.append(locker)
            }
        }
        curLockers.append(tempLockers)
        tempLockers.removeAll()
        for locker in lockers[1]{
            if locker.userId == curUser{
                tempLockers.append(locker)
            }
        }
        curLockers.append(tempLockers)
        tempLockers.removeAll()
        for locker in lockers[2]{
            if locker.userId == curUser{
                tempLockers.append(locker)
            }
        }
        curLockers.append(tempLockers)
        tempLockers.removeAll()
        for locker in lockers[3]{
            if locker.userId == curUser{
                tempLockers.append(locker)
            }
        }
        curLockers.append(tempLockers)
        tempLockers.removeAll()
    }
    
    func initLockers() {
        var max = 28
            for j in 1..<max{
                let db = Firestore.firestore()
                let ref = db.collection("LALockers").document("\(j)")
                ref.setData(["id": j, "isOccupied": false, "userId": ""]){ error in
                    if let error = error {
                        print(error.localizedDescription)
                    }
                    
                }
            }
        for j in 1..<max{
            let db = Firestore.firestore()
            let ref = db.collection("LBLockers").document("\(j)")
            ref.setData(["id": j, "isOccupied": false, "userId": ""]){ error in
                if let error = error {
                    print(error.localizedDescription)
                }
                
            }
        }
        max = 55
        for j in 1..<max{
            let db = Firestore.firestore()
            let ref = db.collection("PALockers").document("\(j)")
            ref.setData(["id": j, "isOccupied": false, "userId": ""]){ error in
                if let error = error {
                    print(error.localizedDescription)
                }
                
            }
        }
        max = 46
        for j in 1..<max{
            let db = Firestore.firestore()
            let ref = db.collection("PBLockers").document("\(j)")
            ref.setData(["id": j, "isOccupied": false, "userId": ""]){ error in
                if let error = error {
                    print(error.localizedDescription)
                }
                
            }
        }
    }
    
    func countAvailLockers() -> Void{
        var count = 0
        for i in 0..<27{
            if !lockers[0][i].isOccupied{
                count += 1
            }
        }
        availLockers[0] = count
        count = 0
        for i in 0..<27{
            if !lockers[1][i].isOccupied{
                count += 1
            }
        }
        availLockers[1] = count
        count = 0
        for i in 0..<54{
            if !lockers[2][i].isOccupied{
                count+=1
            }
        }
        availLockers[2] = count
        count = 0
        for i in 0..<45{
            if !lockers[3][i].isOccupied{
                count+=1
            }
        }
        availLockers[3] = count
    }
    
    func getLockers() {
        availLockers = []
        lockers.removeAll()
        tempLockers.removeAll()
        var availCounter = 0
        let db = Firestore.firestore()
        let ref = db.collection("LALockers")
        ref.getDocuments { snapshot, error in
            guard error == nil else{
                print(error!.localizedDescription)
                return
            }

            if let snapshot = snapshot {
                for document in snapshot.documents {
                    let data = document.data()

                    let id = data["id"] as? Int ?? 0
                    let isOccupied = data["isOccupied"] as? Bool ?? false
                    let userId = data["userId"] as? String ?? ""

                    let locker = Locker(id: id, isOccupied: isOccupied, userId: userId)
                    if !locker.isOccupied {
                        availCounter += 1
                    }
                    self.tempLockers.append(locker)
                    self.tempLockers.sort{
                        $0.id < $1.id
                    }
                }
                self.availLockers.insert(availCounter, at: 0)
                availCounter = 0
                self.lockers.insert(self.tempLockers, at: 0)
                self.tempLockers.removeAll()
            }
        }
        
        
        let ref1 = db.collection("LBLockers")
        ref1.getDocuments { snapshot, error in
            guard error == nil else{
                print(error!.localizedDescription)
                return
            }

            if let snapshot = snapshot {
                for document in snapshot.documents {
                    let data = document.data()

                    let id = data["id"] as? Int ?? 0
                    let isOccupied = data["isOccupied"] as? Bool ?? false
                    let userId = data["userId"] as? String ?? ""

                    let locker = Locker(id: id, isOccupied: isOccupied, userId: userId)
                    if !locker.isOccupied {
                        availCounter += 1
                    }
                    self.tempLockers.append(locker)
                    self.tempLockers.sort{
                        $0.id < $1.id
                    }
                }
                self.availLockers.insert(availCounter, at: 0)
                availCounter = 0
                self.lockers.insert(self.tempLockers, at: 0)
                self.tempLockers.removeAll()
            }
        }
        
        let ref2 = db.collection("PALockers")
        ref2.getDocuments { snapshot, error in
            guard error == nil else{
                print(error!.localizedDescription)
                return
            }

            if let snapshot = snapshot {
                for document in snapshot.documents {
                    let data = document.data()

                    let id = data["id"] as? Int ?? 0
                    let isOccupied = data["isOccupied"] as? Bool ?? false
                    let userId = data["userId"] as? String ?? ""

                    let locker = Locker(id: id, isOccupied: isOccupied, userId: userId)
                    if !locker.isOccupied {
                        availCounter += 1
                    }
                    self.tempLockers.append(locker)
                    self.tempLockers.sort{
                        $0.id < $1.id
                    }
                }
                self.availLockers.insert(availCounter, at: 0)
                availCounter = 0
                self.lockers.insert(self.tempLockers, at: 0)
                self.tempLockers.removeAll()
            }
        }

        let ref3 = db.collection("PBLockers")
        ref3.getDocuments { snapshot, error in
            guard error == nil else{
                print(error!.localizedDescription)
                return
            }

            if let snapshot = snapshot {
                for document in snapshot.documents {
                    let data = document.data()

                    let id = data["id"] as? Int ?? 0
                    let isOccupied = data["isOccupied"] as? Bool ?? false
                    let userId = data["userId"] as? String ?? ""

                    let locker = Locker(id: id, isOccupied: isOccupied, userId: userId)
                    if !locker.isOccupied {
                        availCounter += 1
                    }
                    self.tempLockers.append(locker)
                    self.tempLockers.sort{
                        $0.id < $1.id
                    }
                }
                self.availLockers.insert(availCounter, at: 0)
                availCounter = 0
                self.lockers.insert(self.tempLockers, at: 0)
                self.tempLockers.removeAll()
            }
        }
        
    }
    
    func toggleLockers(section: String, id:Int, action: Bool){
        if action{
            let db = Firestore.firestore()
            let ref = db.collection("\(section)Lockers").document("\(id)")
            ref.setData(["id": id, "isOccupied": action, "userId": curUser]){ error in
                if let error = error {
                    print(error.localizedDescription)
                }
                
            }
        }
        else{
            let db = Firestore.firestore()
            let ref = db.collection("\(section)Lockers").document("\(id)")
            ref.setData(["id": id, "isOccupied": action, "userId": ""]){ error in
                if let error = error {
                    print(error.localizedDescription)
                }
                
            }
        }
        
    }
    
    func getUsers() {
        users.removeAll()
        let db = Firestore.firestore()
        let ref = db.collection("Users")
        ref.getDocuments { snapshot, error in
            guard error == nil else{
                print(error!.localizedDescription)
                return
            }
            
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    let data = document.data()
                    
                    let id = data["id"] as? String ?? ""
                    
                    self.users.append(id)
                }
            }
        }
        
    }
    
    func addCurUser(){
        let db = Firestore.firestore()
        let ref = db.collection("Users").document(curUser)
        ref.setData(["id": curUser]){ error in
            if let error = error {
                print(error.localizedDescription)
            }
            
        }
    }
    

}
