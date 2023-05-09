#include "TestDemo.hpp"


int TestDemo::getDoubleNum(int value)
{
    this->_count_num++;
    return value * 2;
}

int TestDemo::getCountNum()
{
    return this->_count_num;
}
