#ifndef NEWDLLSERIALPORT_H
#define NEWDLLSERIALPORT_H

#include "NewDLLSerialPort_global.h"
#include "enginee.h"

#include <QObject>

class NEWDLLSERIALPORT_EXPORT NewDLLSerialPort: public QObject{
        Q_OBJECT

public:
    NewDLLSerialPort(QObject * parent = nullptr);
    ~NewDLLSerialPort();
    void openAndRead();
    void readPorts();


private:
    QString cardnumber;
    Enginee *engine;

public slots:
    void receiveFromEngine(QString);

signals:
    void sendSignalToExe(QString);
};

#endif // NEWDLLSERIALPORT_H
