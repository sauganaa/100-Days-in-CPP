#include <iostream>

int main() {
    int n, reversedNumber = 0, remainder;
    std::cout << "Enter an integer: ";
    std::cin >> n;
    while(n != 0) {
        remainder = n % 10;
        reversedNumber = reversedNumber * 10 + remainder;
        n /= 10;
    }
    std::cout << "Reversed Number = " << reversedNumber << std::endl;
    return 0;
}
