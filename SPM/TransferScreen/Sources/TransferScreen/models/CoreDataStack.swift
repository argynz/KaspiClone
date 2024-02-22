import CoreData
import Foundation

public class CoreDataStack {
    public static let shared = CoreDataStack()

    public lazy var persistentContainer: NSPersistentContainer = {
        guard let modelURL = Bundle.module.url(forResource: "DataModel", withExtension: "momd") else {
            fatalError("Failed to locate DataModel in bundle.")
        }
        guard let model = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Failed to load model named DataModel")
        }
        let container = NSPersistentContainer(name: "DataModel", managedObjectModel: model)
        container.loadPersistentStores { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    private init() {}
}
