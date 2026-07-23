/*
 * 100 Days in C++ - Day 1
 * Topic: Exception Handling
 * Auto-generated practice file #3
 */
#include <iostream>
#include <stdexcept>
using namespace std;

double divide(double a, double b) {
    if (b == 0) throw runtime_error("Division by zero!");
    return a / b;
}

int main() {
    double pairs[][2] = {{10, 3}, {15, 0}, {20, 4}, {0, 5}};

    for (auto& p : pairs) {
        try {
            cout << p[0] << " / " << p[1] << " = " << divide(p[0], p[1]) << endl;
        } catch (const runtime_error& e) {
            cout << p[0] << " / " << p[1] << " -> Error: " << e.what() << endl;
        }
    }
    return 0;
}
