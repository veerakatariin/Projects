#include "dllpincode.h"


DLLPinCode::DLLPinCode(QObject * parent):QObject(parent)
{
    pPinEngine = new pincodeEngine;
    qDebug()<<"pinEngine luotu";
    /*connect(pPinEngine,SIGNAL(signalToDLLPinCode()),this,SLOT(getSignalFromPinEngine()));
    qDebug()<<"Yhdistettiin pinEnginen SIGNAL DLLPinCoden SLOT:iin";*/

    /*connect(pPinEngine,SIGNAL(signalToDLLPinCodeWithParameter(short)),this,SLOT(getSignalFromPinEngineWithParameter(short)));*/
}

DLLPinCode::~DLLPinCode()
{
    delete pPinEngine;
    pPinEngine = nullptr;
    qDebug()<<"pinEngine tuhottu";
}

void DLLPinCode::openPinWindow(){
    pPinEngine->show();
    pPinEngine->exec();
}


/*void DLLPinCode::signalSend()
{
    pPinEngine->signalToDLLPinCode();
    qDebug()<<"Käsketään pinEngine lähettää signaali";
}*/

QString DLLPinCode::getPin()
{
    return pPinEngine->returnValueToInterface();
}

/*void DLLPinCode::getSignalFromPinEngine()
{
    qDebug()<<"Vastaanotettiin pinEnginen signaali";
    emit signalToExe();
    qDebug()<<"Lähetetään signaali EXE:lle";
}

void DLLPinCode::getSignalFromPinEngineWithParameter(short num)
{
    emit signalToExeWithParameter(num);
}
*/
