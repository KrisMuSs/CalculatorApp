import XCTest
@testable import CalculatorIOS

final class ViewModelTests: XCTestCase {

    private var vm: ViewModel!

    override func setUp() {
        super.setUp()
        vm = ViewModel()
    }

    override func tearDown() {
        vm = nil
        super.tearDown()
    }

    func testDigitInput() {
        vm.didTap(item: .seven)
        XCTAssertEqual(vm.value, "7", "Цифра должна заменять начальный '0'.")
    }

    func testOperatorStart() {
        vm.didTap(item: .plus)
        XCTAssertEqual(vm.value, "0", "Нельзя начинать выражение с оператора.")
    }

    func testAddDigits() {
        vm.didTap(item: .one)
        vm.didTap(item: .two)
        vm.didTap(item: .three)
        XCTAssertEqual(vm.value, "123", "Цифры должны добавляться к значению.")
    }
    
    func testDivisionZero() {
        let result = vm.Сalculating("8/0")
        
        XCTAssertTrue(
            result.isInfinite,
            "При делении на ноль результат должен быть Infinity."
        )
    }
    
    func testReplaceOperator() {
        vm.didTap(item: .two)
        vm.didTap(item: .plus)
        vm.didTap(item: .minus)
        XCTAssertEqual(vm.value, "2-", "Последний оператор должен заменять предыдущий.")
    }

    func testEqual() {
        vm.value = "2+3*4"
        vm.didTap(item: .equal)
        XCTAssertEqual(vm.value, "14", "Нарушен приоритет операций: '*' должно выполняться раньше '+'.")
    }

    func testEqualWithOperatorEnd() {
        vm.value = "2+"
        vm.didTap(item: .equal)
        XCTAssertEqual(vm.value, "2+", "'=' не должен считать, если в конце оператор.")
    }

    func testClearResetsValue() {
        vm.value = "123"
        vm.didTap(item: .clear)
        
        XCTAssertEqual(
            vm.value,
            "0",
            "Кнопка AC должна сбрасывать значение на '0'."
        )
    }

    func testNegativeOnExpression() {
        vm.value = "2+3"
        vm.didTap(item: .negative)
        
        XCTAssertEqual(
            vm.value,
            "2+3",
            "Смена знака не должна работать для выражений, только для одного числа."
        )
    }

    func testEqualOnNumber() {
        vm.value = "123"
        
        vm.didTap(item: .equal)
        
        XCTAssertEqual(
            vm.value,
            "123",
            "Кнопка '=' не должна менять значение, если на экране уже число."
        )
    }
}
