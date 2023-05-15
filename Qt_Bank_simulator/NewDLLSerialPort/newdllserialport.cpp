#include "newdllserialport.h"


NewDLLSerialPort::NewDLLSerialPort(QObject * parent): QObject(parent){

    engine  = new Enginee;
    connect(engine, SIGNAL(sendToInterface(QString)),
            this, SLOT(receiveFromEngine(QString)));
}

NewDLLSerialPort::~NewDLLSerialPort(){

    delete engine;
    engine = nullptr;

}

void NewDLLSerialPort::openAndRead(){
    engine->open();
}

void NewDLLSerialPort::readPorts(){
    engine->info();

}

void NewDLLSerialPort::receiveFromEngine(QString inffo){
    emit sendSignalToExe(inffo);
}

