import Foundation

struct Traveler {
    let name: String
    var totalSpent: Double
}

func calculateBalances(travelers: [Traveler]) -> (
    transactions: [(String, String, Double)], summary: [String: (spent: Double, balance: Double)]
) {
    let totalSpent = travelers.reduce(0) { $0 + $1.totalSpent }
    let averageSpent = totalSpent / Double(travelers.count)

    var balances = [String: Double]()
    for traveler in travelers {
        balances[traveler.name] = traveler.totalSpent - averageSpent
    }

    var transactions = [(String, String, Double)]()

    var sortedBalances = balances.sorted { $0.value < $1.value }

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

    var summary = [String: (spent: Double, balance: Double)]()
    for traveler in travelers {
        summary[traveler.name] = (spent: traveler.totalSpent, balance: balances[traveler.name] ?? 0)
    }

    return (transactions, summary)
}

func main() {
    var travelers = [Traveler]()

    print("请输入旅行者人数：")
    guard let numTravelers = Int(readLine() ?? "0"), numTravelers > 0 else {
        print("输入无效，请输入一个大于 0 的数字。")
        return
    }

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

    let result = calculateBalances(travelers: travelers)
    let transactions = result.transactions
    let summary = result.summary

    let totalSpent = travelers.reduce(0) { $0 + $1.totalSpent }
    let averageSpent = totalSpent / Double(travelers.count)

    print("\n--- 结算结果 ---")
    print("总开销：\(totalSpent)元")
    print("平均每人应支付：\(averageSpent)元\n")

    print("--- 每人已支付金额及余额 ---")
    for (name, data) in summary {
        let balanceDescription = data.balance >= 0 ? "应收款" : "应付款"
        print("\(name): 已支付 \(data.spent)元，\(balanceDescription) \(abs(data.balance))元")
    }

    print("\n--- 支付明细 ---")
    for transaction in transactions {
        print("\(transaction.0) 应该支付 \(transaction.1) \(transaction.2)元")
    }
}

main()
