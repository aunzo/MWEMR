import Foundation

extension UIButton
{
    private struct AssociatedKeys {
        static var isChecked = "isChecked"
    }
    
    var isChecked : Bool {
        get {
            guard let number = objc_getAssociatedObject(self, &AssociatedKeys.isChecked) as? NSNumber else {
                return false
            }
            return number.boolValue
        }
        
        set(value) {
            objc_setAssociatedObject(self,&AssociatedKeys.isChecked,NSNumber(value: value),objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
