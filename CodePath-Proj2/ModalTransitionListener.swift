//
//  ModalTransitionListener.swift
//  CodePath-Proj2
//
//  Created by Alexis Edwards on 4/29/21.
//

import Foundation

protocol ModalTransitionListener {
    func popoverDismissed()
}

class ModalTransitionMediator {
    /* Singleton */
    class var instance: ModalTransitionMediator {
        struct Static {
            static let instance: ModalTransitionMediator = ModalTransitionMediator()
        }
        return Static.instance
    }

private var listener: ModalTransitionListener?

private init() {

}

func setListener(listener: ModalTransitionListener) {
    self.listener = listener
}

func sendPopoverDismissed(modelChanged: Bool) {
    listener?.popoverDismissed()
}
}
