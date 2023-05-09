#include <iostream>
#include "TestDemo.hpp"

int main(int argc, char *argv[]) 
{
    TestDemo demo;

    for (auto i { 0 }; i < 10; ++i) {
        std::cout << "input: " << i << ", output: " 
            << demo.getDoubleNum(i) << ", count: " 
            << demo.getCountNum() << std::endl;
    }

    return 0;
}