#include <iostream>

int main() {
    int n;
    bool isPrime = true;
    std::cout << "Enter a positive integer: ";
    std::cin >> n;
    if (n == 0 || n == 1) {
        isPrime = false;
    } else {
        for (int i = 2; i <= n / 2; ++i) {
            if (n % i == 0) {
                isPrime = false;
                break;
            }
        }
    }
    if (isPrime)
        std::cout << n << " is a prime number." << std::endl;
    else
        std::cout << n << " is not a prime number." << std::endl;
    return 0;
}
