// MIT License
//
// Copyright (c) 2023 John McHen
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import Foundation

// 定义旅行者结构体，包含名字和总花费
struct Traveler {
    let name: String
    var totalSpent: Double
}

// 计算旅行者的结算信息，包括支付明细和每人余额
func calculateBalances(travelers: [Traveler]) -> (
    transactions: [(String, String, Double)], summary: [String: (spent: Double, balance: Double)]
) {
    // 计算总花费和平均花费
    let totalSpent = travelers.reduce(0) { $0 + $1.totalSpent }
    let averageSpent = totalSpent / Double(travelers.count)

    // 计算每个人的余额
    var balances = [String: Double]()
    for traveler in travelers {
        balances[traveler.name] = traveler.totalSpent - averageSpent
    }

    // 计算支付明细
    var transactions = [(String, String, Double)]()

    // 对余额进行排序
    var sortedBalances = balances.sorted { $0.value < $1.value }

    // 使用双指针方法计算支付明细
    var i = 0
    var j = sortedBalances.count - 1

    while i < j {
        let debtor = sortedBalances[i]
        let creditor = sortedBalances[j]

        let amount = min(-debtor.value, creditor.value)

        if amount > 0 {
            transactions.append((debtor.key, creditor.key, amount))

            sortedBalances[i].value += amount
            sortedBalances[j].value -= amount
        }

        if sortedBalances[i].value == 0 {
            i += 1
        }

        if sortedBalances[j].value == 0 {
            j -= 1
        }
    }

    // 构建结算摘要
    var summary = [String: (spent: Double, balance: Double)]()
    for traveler in travelers {
        summary[traveler.name] = (spent: traveler.totalSpent, balance: balances[traveler.name] ?? 0)
    }

    return (transactions, summary)
}

// 主函数，负责读取用户输入并输出结算结果
func main() {
    var travelers = [Traveler]()

    print("请输入旅行者人数：")
    guard let numTravelers = Int(readLine() ?? "0"), numTravelers > 0 else {
        print("输入无效，请输入一个大于 0 的数字。")
        return
    }

    // 读取每个旅行者的名字和花费
    for i in 1...numTravelers {
        print("请输入第\(i)个旅行者的名字和花费（格式：名字:花费）：")
        let input = readLine() ?? ""
        let components = input.components(separatedBy: ":")

        guard components.count == 2, let spent = Double(components[1]) else {
            print("输入格式无效，请使用格式：名字:花费")
            continue
        }

        let name = components[0]
        travelers.append(Traveler(name: name, totalSpent: spent))
    }

    // 计算结算信息
    let result = calculateBalances(travelers: travelers)
    let transactions = result.transactions
    let summary = result.summary

    // 计算总花费和平均花费
    let totalSpent = travelers.reduce(0) { $0 + $1.totalSpent }
    let averageSpent = totalSpent / Double(travelers.count)

    // 输出结算结果
    print("\n--- 结算结果 ---")
    print("总开销：\(String(format: "%.2f", totalSpent))元")
    print("平均每人应支付：\(String(format: "%.2f", averageSpent))元\n")

    print("--- 每人已支付金额及余额 ---")
    for (name, data) in summary {
        let balanceDescription = data.balance >= 0 ? "应收款" : "应付款"
        print("\(name): 已支付 \(String(format: "%.2f", data.spent))元，\(balanceDescription) \(String(format: "%.2f", abs(data.balance)))元")
    }

    print("\n--- 支付明细 ---")
    for transaction in transactions {
        print("\(transaction.0) 应该支付 \(transaction.1) \(String(format: "%.2f", transaction.2))元")
    }
}

// 调用主函数
main()