#include "myclass.h"

MyClass::MyClass(QString paramString) : threadName(paramString){

}

void MyClass::run(){
    for(short i=0; i<= 100; i++){
        qDebug() << this->threadName << ":" << i;

    }
}

MyClass::~MyClass(){

}
