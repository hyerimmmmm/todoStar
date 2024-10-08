//
//  GoalDetailViewModel.swift
//  todoStar
//
//  Created by 김혜림 on 9/9/24.
//

import Foundation
import Combine

struct GoalDetailModel {
    let goalId: UUID
    let lastGoal: String
    let importance: String
    let progressStatus: Bool
    let middleGoal: [MiddleGoalDataModel]
}

class GoalDetailViewModel: CustomSwitchButtonProtocol {
    private let shareData = ShareData.shared

    private let goalId: UUID
    private var goalData: GoalRecordDataModel?

    @Published var selecteGoalData: [GoalDetailModel] = [] {
        didSet {
            if let firstGoal = selecteGoalData.first {
                isOn = firstGoal.progressStatus
            }
        }
    }
    @Published var isOn: Bool = false

    init(goalId: UUID) {
        self.goalId = goalId
        self.goalData = findGoalData(goalId)
        self.loadGoal()
    }

    private func findGoalData(_ id: UUID) -> GoalRecordDataModel? {
        let goalData = shareData.getGoalData()
        let findGoal = goalData.first { $0.goalId == id }

        return findGoal
    }

    private func loadGoal() {
        if let goal = goalData {
            self.selecteGoalData = [
                GoalDetailModel(goalId: goal.goalId,
                                lastGoal: goal.lastGoal,
                                importance: goal.importance,
                                progressStatus: goal.progressStatus,
                                middleGoal: goal.middleGoal)
            ]
        }
    }
}
