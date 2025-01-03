
# 旅行公共花费结算工具

这是一个用 Swift 编写的命令行工具，用于记录旅行者的公共花费，并计算每个人应该支付或收取的金额，以确保最终每个人的支出都是平均的。工具会尽量减少支付次数，使得结算过程更加高效。

---

## 功能

- 记录每个旅行者的名字和总支出。
- 计算总开销和平均每人应支付金额。
- 显示每人已支付金额及余额（应收款或应付款）。
- 生成支付明细，标明谁应该支付谁多少钱，并尽量减少支付次数。

---

## 使用说明

### 1. 安装 Swift
确保你的系统已经安装了 Swift。可以通过以下命令检查是否安装：

```bash
swift --version
```

如果未安装，请参考 [Swift 官方安装指南](https://www.swift.org/getting-started/)。

### 2. 下载代码
将代码保存为一个文件，例如 `TravelExpenseCalculator.swift`。

### 3. 编译代码
在终端中导航到代码所在目录，运行以下命令编译代码：

```bash
swiftc TravelExpenseCalculator.swift -o TravelExpenseCalculator
```

这将生成一个可执行文件 `TravelExpenseCalculator`。

### 4. 运行程序
运行生成的可执行文件：

```bash
./TravelExpenseCalculator
```

### 5. 输入数据
按照程序提示输入以下信息：
- 旅行者人数。
- 每个旅行者的名字和花费，格式为 `名字:花费`（例如 `Alice:100`）。

### 6. 查看结果
程序将输出以下信息：
- 总开销和平均每人应支付金额。
- 每人已支付金额及余额（应收款或应付款）。
- 支付明细，标明谁应该支付谁多少钱。

---

## 示例

假设有三个旅行者：Alice、Bob 和 Charlie，他们的支出分别为 100 元、200 元和 300 元。

运行程序后，输入如下数据：
```shell
请输入旅行者人数：
3
请输入第1个旅行者的名字和花费（格式：名字:花费）：
Alice:100
请输入第2个旅行者的名字和花费（格式：名字:花费）：
Bob:200
请输入第3个旅行者的名字和花费（格式：名字:花费）：
Charlie:300
```


程序将输出：

```
--- 结算结果 ---
总开销：600.0元
平均每人应支付：200.0元

--- 每人已支付金额及余额 ---
Alice: 已支付 100.0元，应付款 100.0元
Bob: 已支付 200.0元，应付款 0.0元
Charlie: 已支付 300.0元，应收款 100.0元

--- 支付明细 ---
Alice 应该支付 Charlie 100.0元
```

---

## 技术说明

### 代码结构
- **Traveler 结构体**：存储每个旅行者的名字和总支出。
- **calculateBalances 函数**：计算每个人的余额（支出与平均支出的差值），并生成需要进行的交易列表，以确保最终每个人的支出都是平均的。
- **main 函数**：负责与用户交互，获取旅行者的信息，并调用 `calculateBalances` 函数来计算并显示结算结果。

### 算法
1. 计算所有旅行者的总支出和平均支出。
2. 计算每个人的余额（支出与平均支出的差值）。
3. 使用贪心算法，将需要支付的人和需要收取的人进行匹配，尽量减少支付次数。

### 依赖
- 该工具仅依赖 Swift 标准库，无需额外安装第三方库。

---

## 许可证
本项目基于 MIT 许可证开源。详情请参阅 [LICENSE](LICENSE) 文件。

---

## 贡献
欢迎提交 Issue 或 Pull Request 来改进此工具！

---

通过这份更新后的 `README.md`，用户可以快速了解工具的功能、使用方法和技术细节。
