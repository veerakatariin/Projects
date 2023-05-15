#include <QCoreApplication>
#include "myclass.h"

int main(int argc, char *argv[])
{
    QCoreApplication a(argc, argv);

    MyClass objectA("A");
    MyClass objectB("B");
    MyClass objectC("C");

    objectA.start();
    objectB.start();
    objectC.start();

    return a.exec();
}
