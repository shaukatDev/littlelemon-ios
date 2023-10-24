import CoreData
import Foundation

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "ExampleDatabase")
        container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        container.loadPersistentStores(completionHandler: {_,_ in })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    func clear() {
        // Delete all dishes from the store
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Dish")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        let _ = try? container.persistentStoreCoordinator.execute(deleteRequest, with: container.viewContext)
    }
    static func mockDish() -> Dish {
        let dish = Dish(context: shared.container.viewContext)
        dish.title = "Mock Dish"
        dish.itemDesc = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam vel sapien ac nunc cursus consectetur. Fusce non dapibus nulla, eu congue nulla. Nulla eu orci nec urna gravida auctor. Nullam vitae scelerisque ante."
        dish.price = "1.0"
        dish.category = "Main"
        dish.image = "https://github.com/Meta-Mobile-Developer-PC/Working-With-Data-API/blob/main/images/grilledFish.jpg?raw=true"
        return dish
    }
}
