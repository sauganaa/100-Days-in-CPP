/*
 * 100 Days in C++ - Day 1
 * Topic: Queue Implementation
 * Auto-generated practice file #2
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
