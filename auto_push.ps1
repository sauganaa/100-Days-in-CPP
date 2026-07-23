# ============================================
# 100 Days in C++ — Auto Push Script
# Generates random C++ code and pushes to GitHub
# Runs 32 times per day (~every 45 minutes)
# ============================================

$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

$repoPath = "c:\Users\spring\Desktop\100-Days-in-CPP"
Set-Location $repoPath

# Calculate current day number (Day 1 = July 23, 2026)
$startDate = [datetime]"2026-07-23"
$today = (Get-Date).Date
$dayNumber = (($today - $startDate).Days) + 1

if ($dayNumber -lt 1) { $dayNumber = 1 }
if ($dayNumber -gt 100) { exit 0 }

$dayFolder = "Day{0:D2}" -f $dayNumber

if (!(Test-Path "$repoPath\$dayFolder")) {
    New-Item -ItemType Directory -Path "$repoPath\$dayFolder" -Force | Out-Null
}

# Count existing files in today's folder to name the new one
$existingFiles = Get-ChildItem "$repoPath\$dayFolder" -Filter "*.cpp" -ErrorAction SilentlyContinue
$fileNumber = ($existingFiles | Measure-Object).Count + 1

# C++ code snippets collection
$snippets = @(
    @{
        Name = "fibonacci"
        Topic = "Recursion"
        Code = @"
/*
 * 100 Days in C++ - Day $dayNumber
 * Topic: Fibonacci Sequence (Recursion)
 * Auto-generated practice file #$fileNumber
 */
#include <iostream>
using namespace std;

int fibonacci(int n) {
    if (n <= 1) return n;
    return fibonacci(n - 1) + fibonacci(n - 2);
}

int main() {
    cout << "Fibonacci Sequence (first 15 terms):" << endl;
    for (int i = 0; i < 15; i++) {
        cout << fibonacci(i) << " ";
    }
    cout << endl;
    return 0;
}
"@
    },
    @{
        Name = "bubble_sort"
        Topic = "Sorting Algorithms"
        Code = @"
/*
 * 100 Days in C++ - Day $dayNumber
 * Topic: Bubble Sort Algorithm
 * Auto-generated practice file #$fileNumber
 */
#include <iostream>
#include <vector>
using namespace std;

void bubbleSort(vector<int>& arr) {
    int n = arr.size();
    for (int i = 0; i < n - 1; i++) {
        for (int j = 0; j < n - i - 1; j++) {
            if (arr[j] > arr[j + 1]) {
                swap(arr[j], arr[j + 1]);
            }
        }
    }
}

int main() {
    vector<int> arr = {64, 34, 25, 12, 22, 11, 90};
    cout << "Before sorting: ";
    for (int x : arr) cout << x << " ";
    cout << endl;

    bubbleSort(arr);

    cout << "After sorting: ";
    for (int x : arr) cout << x << " ";
    cout << endl;
    return 0;
}
"@
    },
    @{
        Name = "linked_list"
        Topic = "Data Structures"
        Code = @"
/*
 * 100 Days in C++ - Day $dayNumber
 * Topic: Singly Linked List
 * Auto-generated practice file #$fileNumber
 */
#include <iostream>
using namespace std;

struct Node {
    int data;
    Node* next;
    Node(int val) : data(val), next(nullptr) {}
};

class LinkedList {
    Node* head;
public:
    LinkedList() : head(nullptr) {}

    void insertFront(int val) {
        Node* newNode = new Node(val);
        newNode->next = head;
        head = newNode;
    }

    void display() {
        Node* temp = head;
        while (temp) {
            cout << temp->data << " -> ";
            temp = temp->next;
        }
        cout << "NULL" << endl;
    }

    ~LinkedList() {
        while (head) {
            Node* temp = head;
            head = head->next;
            delete temp;
        }
    }
};

int main() {
    LinkedList list;
    list.insertFront(10);
    list.insertFront(20);
    list.insertFront(30);
    list.insertFront(40);
    cout << "Linked List: ";
    list.display();
    return 0;
}
"@
    },
    @{
        Name = "binary_search"
        Topic = "Search Algorithms"
        Code = @"
/*
 * 100 Days in C++ - Day $dayNumber
 * Topic: Binary Search
 * Auto-generated practice file #$fileNumber
 */
#include <iostream>
#include <vector>
using namespace std;

int binarySearch(vector<int>& arr, int target) {
    int left = 0, right = arr.size() - 1;
    while (left <= right) {
        int mid = left + (right - left) / 2;
        if (arr[mid] == target) return mid;
        else if (arr[mid] < target) left = mid + 1;
        else right = mid - 1;
    }
    return -1;
}

int main() {
    vector<int> arr = {2, 5, 8, 12, 16, 23, 38, 56, 72, 91};
    int target = 23;
    int result = binarySearch(arr, target);
    if (result != -1)
        cout << "Element " << target << " found at index " << result << endl;
    else
        cout << "Element not found" << endl;
    return 0;
}
"@
    },
    @{
        Name = "stack_impl"
        Topic = "Data Structures"
        Code = @"
/*
 * 100 Days in C++ - Day $dayNumber
 * Topic: Stack Implementation
 * Auto-generated practice file #$fileNumber
 */
#include <iostream>
#include <stack>
using namespace std;

bool isBalanced(string expr) {
    stack<char> s;
    for (char c : expr) {
        if (c == '(' || c == '{' || c == '[') {
            s.push(c);
        } else if (c == ')' || c == '}' || c == ']') {
            if (s.empty()) return false;
            char top = s.top(); s.pop();
            if ((c == ')' && top != '(') ||
                (c == '}' && top != '{') ||
                (c == ']' && top != '['))
                return false;
        }
    }
    return s.empty();
}

int main() {
    string exprs[] = {"{[()]}", "({[})", "((()))", "[{()}]", "(()"};
    for (auto& e : exprs) {
        cout << e << " -> " << (isBalanced(e) ? "Balanced" : "Not Balanced") << endl;
    }
    return 0;
}
"@
    },
    @{
        Name = "class_inheritance"
        Topic = "OOP - Inheritance"
        Code = @"
/*
 * 100 Days in C++ - Day $dayNumber
 * Topic: Inheritance and Polymorphism
 * Auto-generated practice file #$fileNumber
 */
#include <iostream>
#include <string>
using namespace std;

class Shape {
protected:
    string name;
public:
    Shape(string n) : name(n) {}
    virtual double area() = 0;
    virtual void display() {
        cout << name << " - Area: " << area() << endl;
    }
    virtual ~Shape() {}
};

class Circle : public Shape {
    double radius;
public:
    Circle(double r) : Shape("Circle"), radius(r) {}
    double area() override { return 3.14159 * radius * radius; }
};

class Rectangle : public Shape {
    double width, height;
public:
    Rectangle(double w, double h) : Shape("Rectangle"), width(w), height(h) {}
    double area() override { return width * height; }
};

int main() {
    Shape* shapes[] = { new Circle(5), new Rectangle(4, 6) };
    for (auto s : shapes) {
        s->display();
        delete s;
    }
    return 0;
}
"@
    },
    @{
        Name = "string_ops"
        Topic = "Strings"
        Code = @"
/*
 * 100 Days in C++ - Day $dayNumber
 * Topic: String Operations
 * Auto-generated practice file #$fileNumber
 */
#include <iostream>
#include <string>
#include <algorithm>
using namespace std;

bool isPalindrome(string s) {
    string rev = s;
    reverse(rev.begin(), rev.end());
    return s == rev;
}

string reverseWords(string s) {
    string result, word;
    for (int i = s.length() - 1; i >= 0; i--) {
        if (s[i] != ' ') {
            word = s[i] + word;
        } else if (!word.empty()) {
            if (!result.empty()) result += " ";
            result += word;
            word = "";
        }
    }
    if (!word.empty()) {
        if (!result.empty()) result += " ";
        result += word;
    }
    return result;
}

int main() {
    string words[] = {"racecar", "hello", "madam", "world"};
    for (auto& w : words) {
        cout << w << " is " << (isPalindrome(w) ? "" : "not ") << "a palindrome" << endl;
    }
    cout << "\nReverse words: " << reverseWords("Hello World CPP") << endl;
    return 0;
}
"@
    },
    @{
        Name = "vector_ops"
        Topic = "STL Vectors"
        Code = @"
/*
 * 100 Days in C++ - Day $dayNumber
 * Topic: STL Vectors
 * Auto-generated practice file #$fileNumber
 */
#include <iostream>
#include <vector>
#include <algorithm>
#include <numeric>
using namespace std;

int main() {
    vector<int> nums = {15, 3, 28, 7, 42, 19, 11, 36, 1, 50};

    cout << "Original: ";
    for (int n : nums) cout << n << " ";
    cout << endl;

    sort(nums.begin(), nums.end());
    cout << "Sorted: ";
    for (int n : nums) cout << n << " ";
    cout << endl;

    int sum = accumulate(nums.begin(), nums.end(), 0);
    cout << "Sum: " << sum << endl;
    cout << "Average: " << (double)sum / nums.size() << endl;
    cout << "Min: " << *min_element(nums.begin(), nums.end()) << endl;
    cout << "Max: " << *max_element(nums.begin(), nums.end()) << endl;

    return 0;
}
"@
    },
    @{
        Name = "map_demo"
        Topic = "STL Maps"
        Code = @"
/*
 * 100 Days in C++ - Day $dayNumber
 * Topic: STL Maps
 * Auto-generated practice file #$fileNumber
 */
#include <iostream>
#include <map>
#include <string>
using namespace std;

int main() {
    map<string, int> wordCount;
    string words[] = {"apple", "banana", "apple", "cherry", "banana", "apple", "date"};

    for (auto& w : words) {
        wordCount[w]++;
    }

    cout << "Word Frequencies:" << endl;
    for (auto& pair : wordCount) {
        cout << "  " << pair.first << ": " << pair.second << endl;
    }

    cout << "\nTotal unique words: " << wordCount.size() << endl;
    return 0;
}
"@
    },
    @{
        Name = "selection_sort"
        Topic = "Sorting Algorithms"
        Code = @"
/*
 * 100 Days in C++ - Day $dayNumber
 * Topic: Selection Sort
 * Auto-generated practice file #$fileNumber
 */
#include <iostream>
#include <vector>
using namespace std;

void selectionSort(vector<int>& arr) {
    int n = arr.size();
    for (int i = 0; i < n - 1; i++) {
        int minIdx = i;
        for (int j = i + 1; j < n; j++) {
            if (arr[j] < arr[minIdx]) minIdx = j;
        }
        swap(arr[i], arr[minIdx]);
    }
}

int main() {
    vector<int> arr = {29, 10, 14, 37, 13, 5, 44};
    cout << "Before: ";
    for (int x : arr) cout << x << " ";
    cout << endl;

    selectionSort(arr);

    cout << "After:  ";
    for (int x : arr) cout << x << " ";
    cout << endl;
    return 0;
}
"@
    },
    @{
        Name = "insertion_sort"
        Topic = "Sorting Algorithms"
        Code = @"
/*
 * 100 Days in C++ - Day $dayNumber
 * Topic: Insertion Sort
 * Auto-generated practice file #$fileNumber
 */
#include <iostream>
#include <vector>
using namespace std;

void insertionSort(vector<int>& arr) {
    for (int i = 1; i < arr.size(); i++) {
        int key = arr[i];
        int j = i - 1;
        while (j >= 0 && arr[j] > key) {
            arr[j + 1] = arr[j];
            j--;
        }
        arr[j + 1] = key;
    }
}

int main() {
    vector<int> arr = {31, 41, 59, 26, 41, 58};
    cout << "Before: ";
    for (int x : arr) cout << x << " ";
    cout << endl;

    insertionSort(arr);

    cout << "After:  ";
    for (int x : arr) cout << x << " ";
    cout << endl;
    return 0;
}
"@
    },
    @{
        Name = "queue_impl"
        Topic = "Data Structures"
        Code = @"
/*
 * 100 Days in C++ - Day $dayNumber
 * Topic: Queue Implementation
 * Auto-generated practice file #$fileNumber
 */
#include <iostream>
#include <queue>
using namespace std;

int main() {
    queue<string> taskQueue;
    taskQueue.push("Compile code");
    taskQueue.push("Run tests");
    taskQueue.push("Fix bugs");
    taskQueue.push("Deploy");
    taskQueue.push("Celebrate");

    cout << "Processing tasks (FIFO):" << endl;
    int step = 1;
    while (!taskQueue.empty()) {
        cout << "  Step " << step++ << ": " << taskQueue.front() << endl;
        taskQueue.pop();
    }
    cout << "All tasks completed!" << endl;
    return 0;
}
"@
    },
    @{
        Name = "template_func"
        Topic = "Templates"
        Code = @"
/*
 * 100 Days in C++ - Day $dayNumber
 * Topic: Function Templates
 * Auto-generated practice file #$fileNumber
 */
#include <iostream>
#include <string>
using namespace std;

template <typename T>
T findMax(T a, T b) {
    return (a > b) ? a : b;
}

template <typename T>
void swapValues(T& a, T& b) {
    T temp = a;
    a = b;
    b = temp;
}

int main() {
    cout << "Max of 10, 20: " << findMax(10, 20) << endl;
    cout << "Max of 3.14, 2.71: " << findMax(3.14, 2.71) << endl;
    cout << "Max of 'a', 'z': " << findMax('a', 'z') << endl;

    int x = 5, y = 10;
    cout << "\nBefore swap: x=" << x << ", y=" << y << endl;
    swapValues(x, y);
    cout << "After swap:  x=" << x << ", y=" << y << endl;
    return 0;
}
"@
    },
    @{
        Name = "exception_handling"
        Topic = "Exception Handling"
        Code = @"
/*
 * 100 Days in C++ - Day $dayNumber
 * Topic: Exception Handling
 * Auto-generated practice file #$fileNumber
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
"@
    },
    @{
        Name = "pointers"
        Topic = "Pointers"
        Code = @"
/*
 * 100 Days in C++ - Day $dayNumber
 * Topic: Pointers and Dynamic Memory
 * Auto-generated practice file #$fileNumber
 */
#include <iostream>
using namespace std;

int main() {
    // Basic pointers
    int num = 42;
    int* ptr = &num;
    cout << "Value: " << num << endl;
    cout << "Address: " << ptr << endl;
    cout << "Dereferenced: " << *ptr << endl;

    // Dynamic array
    int size = 5;
    int* dynArr = new int[size];
    for (int i = 0; i < size; i++) {
        dynArr[i] = (i + 1) * 10;
    }

    cout << "\nDynamic Array: ";
    for (int i = 0; i < size; i++) {
        cout << dynArr[i] << " ";
    }
    cout << endl;

    delete[] dynArr;
    cout << "Memory freed successfully!" << endl;
    return 0;
}
"@
    },
    @{
        Name = "file_io"
        Topic = "File I/O"
        Code = @"
/*
 * 100 Days in C++ - Day $dayNumber
 * Topic: File Input/Output
 * Auto-generated practice file #$fileNumber
 */
#include <iostream>
#include <fstream>
#include <string>
using namespace std;

int main() {
    // Write to file
    ofstream outFile("sample_output.txt");
    if (outFile.is_open()) {
        outFile << "Hello from 100 Days in C++!" << endl;
        outFile << "Day: $dayNumber" << endl;
        outFile << "File #: $fileNumber" << endl;
        outFile << "Learning File I/O is essential!" << endl;
        outFile.close();
        cout << "File written successfully!" << endl;
    }

    // Read from file
    ifstream inFile("sample_output.txt");
    if (inFile.is_open()) {
        string line;
        cout << "\nFile contents:" << endl;
        while (getline(inFile, line)) {
            cout << "  " << line << endl;
        }
        inFile.close();
    }
    return 0;
}
"@
    },
    @{
        Name = "recursion_patterns"
        Topic = "Recursion"
        Code = @"
/*
 * 100 Days in C++ - Day $dayNumber
 * Topic: Recursion Patterns
 * Auto-generated practice file #$fileNumber
 */
#include <iostream>
using namespace std;

int factorial(int n) {
    if (n <= 1) return 1;
    return n * factorial(n - 1);
}

int power(int base, int exp) {
    if (exp == 0) return 1;
    return base * power(base, exp - 1);
}

int sumDigits(int n) {
    if (n == 0) return 0;
    return (n % 10) + sumDigits(n / 10);
}

int main() {
    cout << "Factorials:" << endl;
    for (int i = 1; i <= 8; i++) {
        cout << "  " << i << "! = " << factorial(i) << endl;
    }

    cout << "\nPowers of 2:" << endl;
    for (int i = 0; i <= 10; i++) {
        cout << "  2^" << i << " = " << power(2, i) << endl;
    }

    cout << "\nSum of digits:" << endl;
    int nums[] = {123, 9999, 5050, 12345};
    for (int n : nums) {
        cout << "  " << n << " -> " << sumDigits(n) << endl;
    }
    return 0;
}
"@
    },
    @{
        Name = "matrix_ops"
        Topic = "2D Arrays"
        Code = @"
/*
 * 100 Days in C++ - Day $dayNumber
 * Topic: Matrix Operations
 * Auto-generated practice file #$fileNumber
 */
#include <iostream>
#include <vector>
using namespace std;

typedef vector<vector<int>> Matrix;

Matrix multiply(Matrix& A, Matrix& B) {
    int n = A.size(), m = B[0].size(), k = B.size();
    Matrix C(n, vector<int>(m, 0));
    for (int i = 0; i < n; i++)
        for (int j = 0; j < m; j++)
            for (int p = 0; p < k; p++)
                C[i][j] += A[i][p] * B[p][j];
    return C;
}

void printMatrix(Matrix& M, string name) {
    cout << name << ":" << endl;
    for (auto& row : M) {
        cout << "  ";
        for (int val : row) cout << val << "\t";
        cout << endl;
    }
}

int main() {
    Matrix A = {{1, 2}, {3, 4}};
    Matrix B = {{5, 6}, {7, 8}};
    Matrix C = multiply(A, B);

    printMatrix(A, "Matrix A");
    printMatrix(B, "Matrix B");
    printMatrix(C, "A x B");
    return 0;
}
"@
    },
    @{
        Name = "enum_switch"
        Topic = "Enums and Switch"
        Code = @"
/*
 * 100 Days in C++ - Day $dayNumber
 * Topic: Enums and Switch Statements
 * Auto-generated practice file #$fileNumber
 */
#include <iostream>
#include <string>
using namespace std;

enum class Color { Red, Green, Blue, Yellow, Purple };
enum class Season { Spring, Summer, Autumn, Winter };

string colorToString(Color c) {
    switch (c) {
        case Color::Red: return "Red";
        case Color::Green: return "Green";
        case Color::Blue: return "Blue";
        case Color::Yellow: return "Yellow";
        case Color::Purple: return "Purple";
        default: return "Unknown";
    }
}

string seasonActivity(Season s) {
    switch (s) {
        case Season::Spring: return "Plant flowers";
        case Season::Summer: return "Go swimming";
        case Season::Autumn: return "Collect leaves";
        case Season::Winter: return "Build snowman";
        default: return "Relax";
    }
}

int main() {
    Color colors[] = {Color::Red, Color::Blue, Color::Green};
    for (auto c : colors) {
        cout << "Color: " << colorToString(c) << endl;
    }

    cout << endl;
    Season seasons[] = {Season::Spring, Season::Summer, Season::Autumn, Season::Winter};
    for (auto s : seasons) {
        cout << "Activity: " << seasonActivity(s) << endl;
    }
    return 0;
}
"@
    },
    @{
        Name = "lambda_funcs"
        Topic = "Lambda Functions"
        Code = @"
/*
 * 100 Days in C++ - Day $dayNumber
 * Topic: Lambda Functions
 * Auto-generated practice file #$fileNumber
 */
#include <iostream>
#include <vector>
#include <algorithm>
using namespace std;

int main() {
    // Basic lambda
    auto greet = []() { cout << "Hello from a lambda!" << endl; };
    greet();

    // Lambda with parameters
    auto add = [](int a, int b) { return a + b; };
    cout << "5 + 3 = " << add(5, 3) << endl;

    // Lambda with capture
    int factor = 3;
    auto multiply = [factor](int x) { return x * factor; };
    cout << "7 * " << factor << " = " << multiply(7) << endl;

    // Lambda with STL
    vector<int> nums = {5, 2, 8, 1, 9, 3, 7};
    sort(nums.begin(), nums.end(), [](int a, int b) { return a > b; });

    cout << "Sorted descending: ";
    for_each(nums.begin(), nums.end(), [](int n) { cout << n << " "; });
    cout << endl;

    return 0;
}
"@
    },
    @{
        Name = "smart_pointers"
        Topic = "Smart Pointers"
        Code = @"
/*
 * 100 Days in C++ - Day $dayNumber
 * Topic: Smart Pointers
 * Auto-generated practice file #$fileNumber
 */
#include <iostream>
#include <memory>
using namespace std;

class Resource {
    string name;
public:
    Resource(string n) : name(n) { cout << "  Created: " << name << endl; }
    ~Resource() { cout << "  Destroyed: " << name << endl; }
    void use() { cout << "  Using: " << name << endl; }
};

int main() {
    cout << "--- unique_ptr ---" << endl;
    {
        unique_ptr<Resource> p1 = make_unique<Resource>("UniqueResource");
        p1->use();
    } // auto destroyed

    cout << "\n--- shared_ptr ---" << endl;
    {
        shared_ptr<Resource> p2 = make_shared<Resource>("SharedResource");
        cout << "  Count: " << p2.use_count() << endl;
        {
            shared_ptr<Resource> p3 = p2;
            cout << "  Count: " << p2.use_count() << endl;
        }
        cout << "  Count: " << p2.use_count() << endl;
    }

    cout << "\nAll resources cleaned up!" << endl;
    return 0;
}
"@
    },
    @{
        Name = "pattern_printing"
        Topic = "Loops and Patterns"
        Code = @"
/*
 * 100 Days in C++ - Day $dayNumber
 * Topic: Pattern Printing with Loops
 * Auto-generated practice file #$fileNumber
 */
#include <iostream>
using namespace std;

int main() {
    int n = 5;

    // Triangle pattern
    cout << "Triangle:" << endl;
    for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= i; j++) cout << "* ";
        cout << endl;
    }

    // Inverted triangle
    cout << "\nInverted Triangle:" << endl;
    for (int i = n; i >= 1; i--) {
        for (int j = 1; j <= i; j++) cout << "* ";
        cout << endl;
    }

    // Number pyramid
    cout << "\nNumber Pyramid:" << endl;
    for (int i = 1; i <= n; i++) {
        for (int s = n - i; s > 0; s--) cout << " ";
        for (int j = 1; j <= i; j++) cout << j << " ";
        cout << endl;
    }

    // Diamond
    cout << "\nDiamond:" << endl;
    for (int i = 1; i <= n; i++) {
        for (int s = n - i; s > 0; s--) cout << " ";
        for (int j = 0; j < 2 * i - 1; j++) cout << "*";
        cout << endl;
    }
    for (int i = n - 1; i >= 1; i--) {
        for (int s = n - i; s > 0; s--) cout << " ";
        for (int j = 0; j < 2 * i - 1; j++) cout << "*";
        cout << endl;
    }
    return 0;
}
"@
    },
    @{
        Name = "calculator"
        Topic = "Switch & Functions"
        Code = @"
/*
 * 100 Days in C++ - Day $dayNumber
 * Topic: Simple Calculator
 * Auto-generated practice file #$fileNumber
 */
#include <iostream>
#include <cmath>
using namespace std;

double calculate(double a, double b, char op) {
    switch (op) {
        case '+': return a + b;
        case '-': return a - b;
        case '*': return a * b;
        case '/': return (b != 0) ? a / b : 0;
        case '^': return pow(a, b);
        default: return 0;
    }
}

int main() {
    char ops[] = {'+', '-', '*', '/', '^'};
    double a = 12, b = 4;

    cout << "Calculator Demo (a=" << a << ", b=" << b << "):" << endl;
    for (char op : ops) {
        cout << "  " << a << " " << op << " " << b << " = " << calculate(a, b, op) << endl;
    }

    cout << "\nSquare root of 144: " << sqrt(144) << endl;
    cout << "Absolute of -25: " << abs(-25) << endl;
    return 0;
}
"@
    },
    @{
        Name = "set_operations"
        Topic = "STL Sets"
        Code = @"
/*
 * 100 Days in C++ - Day $dayNumber
 * Topic: STL Set Operations
 * Auto-generated practice file #$fileNumber
 */
#include <iostream>
#include <set>
#include <algorithm>
#include <vector>
#include <iterator>
using namespace std;

int main() {
    set<int> A = {1, 2, 3, 4, 5};
    set<int> B = {3, 4, 5, 6, 7};

    cout << "Set A: ";
    for (int x : A) cout << x << " ";
    cout << endl;

    cout << "Set B: ";
    for (int x : B) cout << x << " ";
    cout << endl;

    // Union
    vector<int> unionSet;
    set_union(A.begin(), A.end(), B.begin(), B.end(), back_inserter(unionSet));
    cout << "Union: ";
    for (int x : unionSet) cout << x << " ";
    cout << endl;

    // Intersection
    vector<int> interSet;
    set_intersection(A.begin(), A.end(), B.begin(), B.end(), back_inserter(interSet));
    cout << "Intersection: ";
    for (int x : interSet) cout << x << " ";
    cout << endl;

    return 0;
}
"@
    },
    @{
        Name = "struct_demo"
        Topic = "Structs"
        Code = @"
/*
 * 100 Days in C++ - Day $dayNumber
 * Topic: Structs in C++
 * Auto-generated practice file #$fileNumber
 */
#include <iostream>
#include <string>
#include <vector>
using namespace std;

struct Student {
    string name;
    int age;
    double gpa;

    void display() {
        cout << "  " << name << " (Age: " << age << ", GPA: " << gpa << ")" << endl;
    }
};

int main() {
    vector<Student> students = {
        {"Alice", 20, 3.8},
        {"Bob", 22, 3.5},
        {"Charlie", 21, 3.9},
        {"Diana", 19, 4.0}
    };

    cout << "Student Records:" << endl;
    for (auto& s : students) s.display();

    // Find highest GPA
    Student* top = &students[0];
    for (auto& s : students) {
        if (s.gpa > top->gpa) top = &s;
    }
    cout << "\nTop student: " << top->name << " with GPA " << top->gpa << endl;
    return 0;
}
"@
    },
    @{
        Name = "operator_overloading"
        Topic = "Operator Overloading"
        Code = @"
/*
 * 100 Days in C++ - Day $dayNumber
 * Topic: Operator Overloading
 * Auto-generated practice file #$fileNumber
 */
#include <iostream>
using namespace std;

class Vector2D {
public:
    double x, y;
    Vector2D(double x = 0, double y = 0) : x(x), y(y) {}

    Vector2D operator+(const Vector2D& v) { return Vector2D(x + v.x, y + v.y); }
    Vector2D operator-(const Vector2D& v) { return Vector2D(x - v.x, y - v.y); }
    Vector2D operator*(double scalar) { return Vector2D(x * scalar, y * scalar); }
    bool operator==(const Vector2D& v) { return x == v.x && y == v.y; }

    friend ostream& operator<<(ostream& os, const Vector2D& v) {
        os << "(" << v.x << ", " << v.y << ")";
        return os;
    }
};

int main() {
    Vector2D a(3, 4), b(1, 2);
    cout << "a = " << a << endl;
    cout << "b = " << b << endl;
    cout << "a + b = " << (a + b) << endl;
    cout << "a - b = " << (a - b) << endl;
    cout << "a * 2 = " << (a * 2) << endl;
    cout << "a == b? " << (a == b ? "Yes" : "No") << endl;
    return 0;
}
"@
    },
    @{
        Name = "bfs_graph"
        Topic = "Graph Algorithms"
        Code = @"
/*
 * 100 Days in C++ - Day $dayNumber
 * Topic: BFS Graph Traversal
 * Auto-generated practice file #$fileNumber
 */
#include <iostream>
#include <vector>
#include <queue>
using namespace std;

void bfs(vector<vector<int>>& adj, int start) {
    vector<bool> visited(adj.size(), false);
    queue<int> q;
    visited[start] = true;
    q.push(start);

    cout << "BFS from node " << start << ": ";
    while (!q.empty()) {
        int node = q.front(); q.pop();
        cout << node << " ";
        for (int neighbor : adj[node]) {
            if (!visited[neighbor]) {
                visited[neighbor] = true;
                q.push(neighbor);
            }
        }
    }
    cout << endl;
}

int main() {
    int n = 6;
    vector<vector<int>> adj(n);
    adj[0] = {1, 2};
    adj[1] = {0, 3, 4};
    adj[2] = {0, 4};
    adj[3] = {1, 5};
    adj[4] = {1, 2, 5};
    adj[5] = {3, 4};

    bfs(adj, 0);
    return 0;
}
"@
    },
    @{
        Name = "dfs_graph"
        Topic = "Graph Algorithms"
        Code = @"
/*
 * 100 Days in C++ - Day $dayNumber
 * Topic: DFS Graph Traversal
 * Auto-generated practice file #$fileNumber
 */
#include <iostream>
#include <vector>
using namespace std;

void dfs(vector<vector<int>>& adj, int node, vector<bool>& visited) {
    visited[node] = true;
    cout << node << " ";
    for (int neighbor : adj[node]) {
        if (!visited[neighbor]) {
            dfs(adj, neighbor, visited);
        }
    }
}

int main() {
    int n = 6;
    vector<vector<int>> adj(n);
    adj[0] = {1, 2};
    adj[1] = {0, 3};
    adj[2] = {0, 4};
    adj[3] = {1, 5};
    adj[4] = {2};
    adj[5] = {3};

    vector<bool> visited(n, false);
    cout << "DFS from node 0: ";
    dfs(adj, 0, visited);
    cout << endl;
    return 0;
}
"@
    },
    @{
        Name = "merge_sort"
        Topic = "Sorting Algorithms"
        Code = @"
/*
 * 100 Days in C++ - Day $dayNumber
 * Topic: Merge Sort
 * Auto-generated practice file #$fileNumber
 */
#include <iostream>
#include <vector>
using namespace std;

void merge(vector<int>& arr, int l, int m, int r) {
    vector<int> left(arr.begin() + l, arr.begin() + m + 1);
    vector<int> right(arr.begin() + m + 1, arr.begin() + r + 1);
    int i = 0, j = 0, k = l;
    while (i < left.size() && j < right.size()) {
        arr[k++] = (left[i] <= right[j]) ? left[i++] : right[j++];
    }
    while (i < left.size()) arr[k++] = left[i++];
    while (j < right.size()) arr[k++] = right[j++];
}

void mergeSort(vector<int>& arr, int l, int r) {
    if (l < r) {
        int m = l + (r - l) / 2;
        mergeSort(arr, l, m);
        mergeSort(arr, m + 1, r);
        merge(arr, l, m, r);
    }
}

int main() {
    vector<int> arr = {38, 27, 43, 3, 9, 82, 10};
    cout << "Before: ";
    for (int x : arr) cout << x << " ";
    cout << endl;

    mergeSort(arr, 0, arr.size() - 1);

    cout << "After:  ";
    for (int x : arr) cout << x << " ";
    cout << endl;
    return 0;
}
"@
    },
    @{
        Name = "quick_sort"
        Topic = "Sorting Algorithms"
        Code = @"
/*
 * 100 Days in C++ - Day $dayNumber
 * Topic: Quick Sort
 * Auto-generated practice file #$fileNumber
 */
#include <iostream>
#include <vector>
using namespace std;

int partition(vector<int>& arr, int low, int high) {
    int pivot = arr[high];
    int i = low - 1;
    for (int j = low; j < high; j++) {
        if (arr[j] < pivot) {
            swap(arr[++i], arr[j]);
        }
    }
    swap(arr[i + 1], arr[high]);
    return i + 1;
}

void quickSort(vector<int>& arr, int low, int high) {
    if (low < high) {
        int pi = partition(arr, low, high);
        quickSort(arr, low, pi - 1);
        quickSort(arr, pi + 1, high);
    }
}

int main() {
    vector<int> arr = {10, 80, 30, 90, 40, 50, 70};
    cout << "Before: ";
    for (int x : arr) cout << x << " ";
    cout << endl;

    quickSort(arr, 0, arr.size() - 1);

    cout << "After:  ";
    for (int x : arr) cout << x << " ";
    cout << endl;
    return 0;
}
"@
    }
)

# Pick a random snippet
$randomIndex = Get-Random -Minimum 0 -Maximum $snippets.Count
$snippet = $snippets[$randomIndex]

$fileName = "{0:D2}_{1}.cpp" -f $fileNumber, $snippet.Name
$filePath = "$repoPath\$dayFolder\$fileName"

# Don't create if file already exists with same name
if (Test-Path $filePath) {
    $fileName = "{0:D2}_{1}_v{2}.cpp" -f $fileNumber, $snippet.Name, (Get-Random -Minimum 100 -Maximum 999)
    $filePath = "$repoPath\$dayFolder\$fileName"
}

$snippet.Code | Out-File -FilePath $filePath -Encoding UTF8

# Git add, commit, push
Set-Location $repoPath
& git add -A
& git commit -m "Day $dayNumber`: $($snippet.Topic) - $($snippet.Name) (auto-commit #$fileNumber) $(Get-Date -Format 'HH:mm')"
& git push origin master

Write-Host "Pushed: $dayFolder/$fileName ($($snippet.Topic))"
