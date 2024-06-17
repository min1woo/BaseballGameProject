//
//  main.swift
//  BaseballGame
//
//  Created by 유민우 on 6/17/24.
//


import Foundation

func generateNumbers() -> [Int] {
    var numbers = Array(1...9)
    numbers.shuffle()
    return Array(numbers.prefix(3))
}

func getUserInput() -> [Int]? {
    print("1에서 9까지의 서로 다른 숫자 3개를 입력하세요 (예: 1 2 3): ", terminator: "")
    
    guard let input = readLine() else {
        return nil
    }
    
    let components = input.split(separator: " ").compactMap { Int($0) }
    
    if components.count == 3, Set(components).count == 3, components.allSatisfy({ 1...9 ~= $0 }) {
        return components
    } else {
        print("잘못된 입력입니다. 1에서 9까지의 서로 다른 숫자 3개를 공백으로 구분하여 입력하세요.")
        return nil
    }
}

func checkGuess(answer: [Int], guess: [Int]) -> (strike: Int, ball: Int) {
    var strike = 0
    var ball = 0
    
    for (index, number) in guess.enumerated() {
        if answer[index] == number {
            strike += 1
        } else if answer.contains(number) {
            ball += 1
        }
    }
    
    return (strike, ball)
}

func start() {
    let answer = generateNumbers()
    var attempts = 0
    
    print("숫자 맞추기 야구 게임에 오신 것을 환영합니다!")
    print("1에서 9까지의 서로 다른 숫자 3개를 맞춰보세요.")
    
    while true {
        guard let guess = getUserInput() else {
            continue
        }
        
        attempts += 1
        let result = checkGuess(answer: answer, guess: guess)
        
        if result.strike == 3 {
            print("축하합니다! \(attempts)번 만에 정답을 맞추셨습니다: \(answer)")
            break
        } else {
            print("\(result.strike) 스트라이크, \(result.ball) 볼")
        }
    }
}


