#ifndef MYCLASS_H
#define MYCLASS_H

#include <QThread>
#include <QDebug>


class MyClass : public QThread
{

public:
    MyClass(QString paramString);
    ~MyClass();

private:
    QString threadName;

protected:
    virtual void run() override;

};

#endif // MYCLASS_H
