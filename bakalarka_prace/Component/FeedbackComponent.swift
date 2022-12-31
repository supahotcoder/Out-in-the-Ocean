//
// Created by Jan Czerny on 12/11/2019.
// Copyright (c) 2019 Jan Czerny. All rights reserved.
//

import Foundation
import GameplayKit

class FeedbackComponent : GKComponent {

    private let feedbackHint: Dictionary<GKEntity,[String]>?
    private let feedbackTouch: Dictionary<bitmasks,[String]>?
    private var feedbackPlayer: Dictionary<bitmasks,[String]>?
    private var lastTouched: GKEntity? = nil

    private var lastFeedbackTime: Date = Date()
    private var lastPlayerFeedbackTime: Date = Date()

    init(feedbackHint: Dictionary<GKEntity,[String]>, feedbackTouch: Dictionary<bitmasks,[String]>, feedbackPlayer: Dictionary<bitmasks,[String]>) {
        self.feedbackHint = feedbackHint
        self.feedbackTouch = feedbackTouch
        self.feedbackPlayer = feedbackPlayer
        super.init()
    }

    init(feedbackHint: Dictionary<GKEntity,[String]>) {
        self.feedbackHint = feedbackHint
        self.feedbackTouch = nil
        self.feedbackPlayer = nil
        super.init()
    }

    init(feedbackTouch: Dictionary<bitmasks,[String]>) {
        self.feedbackTouch = feedbackTouch
        self.feedbackHint = nil
        self.feedbackPlayer = nil
        super.init()
    }

    func giveTouchFeedback(on: bitmasks) -> String{
        let currDate = Date()
        if (currDate.timeIntervalSince(lastFeedbackTime) >= 1){
            lastFeedbackTime = currDate
            return (feedbackTouch == nil || feedbackTouch!.isEmpty) ? "" : feedbackTouch![on]?.randomElement() ?? ""
        }
        return ""
    }

    func giveFeedbackHint(on: GKEntity) -> String{
        return (feedbackHint == nil || feedbackHint!.isEmpty) ? "" : feedbackHint![on]?.randomElement() ?? ""
    }
    
    func givePlayerThought(on: bitmasks) -> String{
        let currDate = Date()
        if (currDate.timeIntervalSince(lastPlayerFeedbackTime) >= 1){
            lastPlayerFeedbackTime = currDate
            var feedbackText = ""
            if let fPlayer = feedbackPlayer{
                feedbackPlayer?.removeValue(forKey: on)
                feedbackText = fPlayer[on]?.first ?? ""
            }
            return feedbackText
        }
        return ""
    }

    func giveHintOnLastTouched() -> String{
        return lastTouched == nil || feedbackHint == nil || feedbackHint!.isEmpty ? "" : feedbackHint![lastTouched!]?.randomElement() ?? ""
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
