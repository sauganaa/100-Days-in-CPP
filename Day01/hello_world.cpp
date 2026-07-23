/*
 * ============================================
 *  100 Days in C++ — Day 1
 *  Date: July 23, 2026
 *  Topic: Hello World & Basics
 * ============================================
 *
 *  Today marks the beginning of the 100 Days in C++ challenge!
 *  We start with the classic "Hello, World!" program and explore
 *  basic C++ concepts: output, variables, data types, and
 *  simple arithmetic.
 */

#include <iostream>
#include <string>

using namespace std;

int main() {
    // --- Hello World ---
    cout << "========================================" << endl;
    cout << "  🚀 100 Days in C++ — Day 1 🚀" << endl;
    cout << "========================================" << endl;
    cout << endl;
    cout << "Hello, World! Welcome to C++!" << endl;
    cout << endl;

    // --- Variables and Data Types ---
    int day = 1;
    int totalDays = 100;
    string challengeName = "100 Days in C++";
    double progress = (static_cast<double>(day) / totalDays) * 100.0;
    bool isStarted = true;
    char grade = 'A';

    cout << "--- Challenge Info ---" << endl;
    cout << "Challenge: " << challengeName << endl;
    cout << "Current Day: " << day << " / " << totalDays << endl;
    cout << "Progress: " << progress << "%" << endl;
    cout << "Started: " << (isStarted ? "Yes" : "No") << endl;
    cout << "Target Grade: " << grade << endl;
    cout << endl;

    // --- Basic Arithmetic ---
    int a = 15, b = 4;
    cout << "--- Basic Arithmetic ---" << endl;
    cout << a << " + " << b << " = " << (a + b) << endl;
    cout << a << " - " << b << " = " << (a - b) << endl;
    cout << a << " * " << b << " = " << (a * b) << endl;
    cout << a << " / " << b << " = " << (a / b) << " (integer division)" << endl;
    cout << a << " % " << b << " = " << (a % b) << " (modulo)" << endl;
    cout << static_cast<double>(a) << " / " << b << " = "
         << (static_cast<double>(a) / b) << " (float division)" << endl;
    cout << endl;

    // --- Sizeof Operator ---
    cout << "--- Size of Data Types (bytes) ---" << endl;
    cout << "int:    " << sizeof(int) << endl;
    cout << "float:  " << sizeof(float) << endl;
    cout << "double: " << sizeof(double) << endl;
    cout << "char:   " << sizeof(char) << endl;
    cout << "bool:   " << sizeof(bool) << endl;
    cout << "string: " << sizeof(string) << endl;
    cout << endl;

    cout << "Day 1 complete! See you tomorrow! 🎉" << endl;

    return 0;
}
