import Foundation
import RealmSwift
import ObjectMapper

class MedicalBagDetail: Object,Mappable {
    
    @objc dynamic var bag_id = 0
    @objc dynamic var name = ""
    var bagEquipments = List<MedicalBagDetailEquipments>()
    var bagMedications = List<MedicalBagDetailMedications>()
    
    required convenience init?(map: ObjectMapper.Map) {
        self.init()
    }
    
    // Mappable
    func mapping(map: ObjectMapper.Map) {
        bag_id <- map["BAG_ID"]
        name <- map["BAG_NAME"]
        bagEquipments <- (map["BagEquipments"], ArrayTransform<MedicalBagDetailEquipments>())
        bagMedications <- (map["BagMedications"], ArrayTransform<MedicalBagDetailMedications>())
    }
    
    override static func primaryKey() -> String? {
        return "bag_id"
    }
}

class MedicalBagDetailEquipments: Object,Mappable {
    
    @objc dynamic var id = 0
    @objc dynamic var barcode = ""
    @objc dynamic var name = ""
    @objc dynamic var type_name = ""
    
    required convenience init?(map: ObjectMapper.Map) {
        self.init()
    }
    
    // Mappable
    func mapping(map: ObjectMapper.Map) {
        id <- map["EQU_HISTORY_ID"]
        barcode <- map["EQUIP_BARCODE"]
        name <- map["EQUIP_NAME"]
        type_name <- map["MaterData_EQUIP_TYPE_NAME"]
        
    }
    
    override static func primaryKey() -> String? {
        return "barcode"
    }
}

class MedicalBagDetailMedications: Object,Mappable {
    
    @objc dynamic var id = 0
    @objc dynamic var amount = 0
    @objc dynamic var barcode = ""
    @objc dynamic var name = ""
    @objc dynamic var group_name = ""
    @objc dynamic var type_name = ""
    
    required convenience init?(map: ObjectMapper.Map) {
        self.init()
    }
    
    // Mappable
    func mapping(map: ObjectMapper.Map) {
        id <- map["Medication_MEDICATION_ID"]
        amount <- map["BAG_MED_AMOUNT"]
        barcode <- map["MEDICATION_BARCODE"]
        name <- map["MEDICATION_NAME"]
        group_name <- map["MasterData_MEDICAL_GROUP_NAME"]
        type_name <- map["MasterData_MEDICAL_TYPE_NAME"]
        
    }
    
    override static func primaryKey() -> String? {
        return "barcode"
    }
}
