#include "enginee.h"

Enginee::Enginee(QObject * parent): QObject(parent){

    PSerialPort = new QSerialPort;
    PSerialPortInfo = new QSerialPortInfo;
}

Enginee::~Enginee(){

    delete PSerialPort;
    PSerialPort = nullptr;
    delete PSerialPortInfo;
    PSerialPortInfo = nullptr;

}

void Enginee::open(){

    PSerialPort->setPortName("COM4");
    PSerialPort->setBaudRate(9600);
    PSerialPort->setDataBits(QSerialPort::Data8);
    PSerialPort->setParity(QSerialPort::NoParity);
    PSerialPort->setStopBits(QSerialPort::OneStop);
    PSerialPort->setFlowControl(QSerialPort::HardwareControl);


    if(!PSerialPort->open(QIODevice::ReadWrite)){
        qDebug() << "ei aukea" << Qt::endl;

    }
    else{
         qDebug() << "portti aukesi"<< Qt::endl;
         PSerialPort->waitForReadyRead();
         qDebug() << PSerialPortInfo->serialNumber();
         emit sendToInterface(PSerialPort->readAll());

    }
    qDebug() << "suljetaan";
    PSerialPort->close();


}

void Enginee::info(){

    QList<QSerialPortInfo> ports = PSerialPortInfo->availablePorts();

    foreach(QSerialPortInfo info, ports){
        emit sendToInterface(info.serialNumber());
    }

}
