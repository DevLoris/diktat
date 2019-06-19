import Foundation

/*
Stocke les images déjà vu lors de l'expérience, pour pouvoir les retrouver dans la collection.
 */
class Historized {
    static let instance = Historized()
    
    var viewed:[String:ImageNode] = [:];
    
    func addViewedPoster(_ node: ImageNode) {
        self.viewed[node.identifier] = node
    }
}
