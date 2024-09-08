//
//  StepProgressView.swift
//  YoriJori
//
//  Created by 예지 on 9/8/24.
//

import SwiftUI

struct StepProgressView: View {
    private var totalStepCount: Int
    private var currentStep: Int
    private var stepPassedStatus: [Bool]
    
    init(totalStepCount: Int, currnetStep: Int) {
        self.totalStepCount = totalStepCount
        self.currentStep = currnetStep
        stepPassedStatus = Array(repeating: false, count: totalStepCount)
        for i in 0..<currnetStep {
            stepPassedStatus[i] = true
        }
    }
    
    var body: some View {
        HStack(spacing: 4, content: {
            ForEach(0..<totalStepCount, id: \.self) { index in
                StepBorderView(passed: stepPassedStatus[index])
            }
        })
    }
}

struct StepBorderView: View {
    @State private var passed: Bool
    
    init(passed: Bool) {
        self.passed = passed
    }
    
    var body: some View {
        Rectangle()
            .fill(passed ? .orange : .gray)
            .frame(height: 8)
    }
}

#Preview {
    StepProgressView(totalStepCount: 4, currnetStep: 1)
}
