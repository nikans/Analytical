//
//  FlurryProvider.swift
//  Analytical
//
//  Created by Dal Rupnik on 18/07/16.
//  Copyright © 2016 Unified Sense. All rights reserved.
//

import Fabric
import Answers

public class AnswersProvider : Provider<Flurry>, Analytical {
    
    public init () {
        super.init()
    }
    
    public func setup(with properties: Properties?) {
        Fabric.with([Answers.self])
    }
    
    public func flush() {
    }
    
    public func reset() {
        
    }
    
    public override func event(name: EventName, properties: Properties?) {
        Answers.logCustomEventWithName(name, customAttributes: properties)
    }
    
    public func screen(name: EventName, properties: Properties?) {
        Answers.logContentViewWithName(
            name,
            contentType: properties["contentType"],
            contentId: properties["contentId"],
            customAttributes: properties.filter({ $0.0 != "contentType" && $0.0 != "contentId" })
        )
    }
    
    public func purchase(amount: NSDecimalNumber, properties: Properties?) {
        Answers.logPurchaseWithPrice(
            properties[Property.price.rawValue],
            currency: properties[Property.Purchase.Currency.rawValue],
            success: properties["success"],
            itemName: properties[Property.item.rawValue],
            itemType: properties[Property.category.rawValue],
            itemId: properties[Property.Purchase.sku.rawValue],
            customAttributes: nil
        )
    }    
}
