//
//  CloudKitCrudBootcamp.swift
//  SwiftfulThinkingAdvancedLearning
//
//  Created by 朱双泉 on 2023/5/30.
//

import SwiftUI
import CloudKit

struct FruitModel: Hashable {
    let name: String
    let imageURL: URL?
    let record: CKRecord
}

class CloudKitCrudBootcampViewModel: ObservableObject {
    
    @Published var text: String = ""
    @Published var fruits: [FruitModel] = []
    
    init() {
        fetchItems()
    }
    
    func addButtonPressed() {
        guard !text.isEmpty else { return }
        addItem(name: text)
    }
    
    private func addItem(name: String) {
        let newFruit = CKRecord(recordType: "Fruits")
        newFruit["name"] = name
        
        guard
            let image = UIImage(named: "therock"),
            let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent("therock.jpg"),
            let data = image.jpegData(compressionQuality: 1.0) else { return }
        
        do {
            try data.write(to: url)
            let asset = CKAsset(fileURL: url)
            newFruit["image"] = asset
            saveItem(record: newFruit)
        } catch let error {
            print(error)
        }
        
    }
    
    private func saveItem(record: CKRecord) {
        CKContainer.default().publicCloudDatabase.save(record) { [weak self] returnedRecord, returnedError in
            print("Record: \(returnedRecord)")
            print("Error: \(returnedError)")
            
            DispatchQueue.main.async {
                self?.text = ""
                self?.fetchItems()
            }
        }
    }
    
    func fetchItems() {
        //        let predicate = NSPredicate(value: true)
        let predicate = NSPredicate(format: "name = %@", argumentArray: ["Coconut"])
        let query = CKQuery(recordType: "Fruits", predicate: predicate)
        query.sortDescriptors = [NSSortDescriptor(key: "creationData", ascending: true)]
        let queryOperation = CKQueryOperation(query: query)
        //        queryOperation.resultsLimit = 2 // 100
        
        var returnedItems: [FruitModel] = []
        
        if #available(iOS 15.0, *) {
            queryOperation.recordMatchedBlock = { (returnedRecordID, returnedResult) in
                switch returnedResult {
                case .success(let record):
                    guard let name = record["name"] as? String else { return }
                    let imageAsset = record["image"] as? CKAsset
                    let imageURL = imageAsset?.fileURL
                    print(record)
                    returnedItems.append(FruitModel(name: name, imageURL: imageURL, record: record))
                case .failure(let error):
                    print("Error recordMatchedBlock: \(error)")
                }
            }
        } else {
            queryOperation.recordFetchedBlock = { (returnedRecord) in
                guard let name = returnedRecord["name"] as? String else { return }
                let imageAsset = returnedRecord["image"] as? CKAsset
                let imageURL = imageAsset?.fileURL
                returnedItems.append(FruitModel(name: name, imageURL: imageURL, record: returnedRecord))
            }
        }
        
        if #available(iOS 15.0, *) {
            queryOperation.queryResultBlock = { [weak self] returnedResult in
                print("RETURNED queryResultBlock: \(returnedResult)")
                DispatchQueue.main.async {
                    self?.fruits = returnedItems
                }
            }
        } else {
            queryOperation.queryCompletionBlock = { [weak self] (returnedCursor, returnError) in
                print("RETURNED queryCompletionBlock")
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self?.fruits = returnedItems
                }
            }
        }
        
        addOperation(operation: queryOperation)
    }
    
    func addOperation(operation: CKDatabaseOperation) {
        CKContainer.default().publicCloudDatabase.add(operation)
    }
    
    func updateItem(fruit: FruitModel) {
        let record = fruit.record
        record["name"] = "NEW NAME!!!!!!"
        saveItem(record: record)
    }
    
    func deleteItem(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let fruit = fruits[index]
        let record = fruit.record
        
        CKContainer.default().publicCloudDatabase.delete(withRecordID: record.recordID) { [weak self] returnedRecordID, returnError in
            DispatchQueue.main.async {
                self?.fruits.remove(at: index)
            }
        }
    }
}

struct CloudKitCrudBootcamp: View {
    
    @StateObject private var vm = CloudKitCrudBootcampViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                header
                textField
                addButton
                
                List {
                    ForEach(vm.fruits, id: \.self) { fruit in
                        HStack {
                            Text(fruit.name)
                            
                            if let url = fruit.imageURL, let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                                Image(uiImage: image)
                                    .resizable()
                                    .frame(width: 50, height: 50)
                            }
                        }
                        .onTapGesture {
                            vm.updateItem(fruit: fruit)
                        }
                    }
                    .onDelete(perform: vm.deleteItem)
                }
                .listStyle(PlainListStyle())
            }
            .padding()
            .navigationBarHidden(true)
        }
    }
}

struct CloudKitCrudBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CloudKitCrudBootcamp()
    }
}

extension CloudKitCrudBootcamp {
    
    private var header: some View {
        Text("CloudKit CRUD ☁️☁️☁️")
            .font(.headline)
            .underline()
    }
    
    private var textField: some View {
        TextField("Add something here...", text: $vm.text)
            .frame(height: 55)
            .padding(.leading)
            .background(Color.gray.opacity(0.4))
            .cornerRadius(10)
    }
    
    private var addButton: some View {
        Button {
            vm.addButtonPressed()
        } label: {
            Text("Add")
                .font(.headline)
                .foregroundColor(.white)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(Color.pink)
                .cornerRadius(10)
        }
    }
}
