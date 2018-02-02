import UIKit
import RxSwift
import RealmSwift

class PreFlightViewModel {
    var interventionChange = PublishSubject<DataAction>()
    var summaryReportChange = PublishSubject<DataAction>()
    var flightPersonChange = PublishSubject<DataAction>()
    var interventionItems:Results<Intervention>?
    var flightPersonItems:Results<FlightPerson>?
    var summaryReportItems:Results<SummaryReport>?
    let realm = try! Realm()
    
}
