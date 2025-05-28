//
//  User.swift
//  LadoB
//
//  Created by Vítor Bruno on 19/05/25.
//

import Foundation

struct User {
    let email: String
    let password: String
    let subscriptionPlain: SubscriptionPlainEnum
    var connectedApps: [AppEnum]
    var albunsOnDisco: Int
    var albunsOnFavorites: Int
    var albunsOnWishList: Int
}
