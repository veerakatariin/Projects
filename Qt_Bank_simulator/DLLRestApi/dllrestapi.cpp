#include "dllrestapi.h"

DLLRestApi::DLLRestApi(QObject *parent): QObject(parent){

    pengine = new engine(this);
    connect(pengine, SIGNAL(sendSaldoToInterface(QString)),
            this, SLOT(saldoFromEngine(QString)));
    connect(pengine, SIGNAL(sendCardToInterface(QString)),
            this, SLOT(cardFromEngine(QString)));
    connect(pengine, SIGNAL(sendCardnumberToInterface(QString)),
            this, SLOT(cardnumberFromEngine(QString)));

    connect(pengine, SIGNAL(sendCustomerToInterface(QString)),
            this, SLOT(customerFromEngine(QString)));
    connect(pengine, SIGNAL(sendActionsToInterface(QString)),
                this, SLOT(actionsFromEngine(QString)));
    connect(pengine, SIGNAL(depositToInterface()),
            this, SLOT(depositFromEngine()));
    connect(pengine, SIGNAL(withdrawalToInterface()),
            this, SLOT(withdrawalFromEngine()));
    connect(pengine, SIGNAL(sendNameToInterface(QString)),
            this, SLOT(nameFromEngine(QString)));


    connect(pengine, SIGNAL(manyActionsToInterface(QString)),
            this, SLOT(manyActionsFromEngine(QString)));
}

DLLRestApi::~DLLRestApi(){

    delete pengine;
    pengine = nullptr;
}

void DLLRestApi::getManyActions(QString id, QString actionid){
    pengine->postManyActions(id, actionid);
}

void DLLRestApi::manyActionsFromEngine(QString action){
    emit manyActionsToExe(action);
    qDebug() << action + "interfaces";
}

void DLLRestApi::getSaldo(QString id){
    pengine->makeSaldoRequest(id);
}

void DLLRestApi::getCustomer(QString id){
    pengine->makeCustomerRequest(id);
}

void DLLRestApi::getActions(QString id){
    pengine->makeActionsRequest(id);
}

void DLLRestApi::getCard(QString id){
    pengine->makeCardRequest(id);
    qDebug() << "haetaan id interfacessa";
}


void DLLRestApi::getNewAction(QString amount, QString id){
    pengine->postAction(amount,id);
}

void DLLRestApi::getNewWithdrawal(QString amount, QString id){
    pengine->postWithdrawal(amount, id);
}

void DLLRestApi::cardFromEngine(QString card){

    emit cardToExe(card);
}

void DLLRestApi::cardnumberFromEngine(QString cardnumber){
    emit cardnumberToExe(cardnumber);
}

void DLLRestApi::saldoFromEngine(QString saldo){

     emit saldoToExe(saldo);
}

void DLLRestApi::actionsFromEngine(QString action){

    emit actionsToExe(action);
}

void DLLRestApi::customerFromEngine(QString customer){

    emit customerToExe(customer);
}

void DLLRestApi::depositFromEngine(){

    emit depositToExe();
}

void DLLRestApi::withdrawalFromEngine(){
    emit withdrawalToExe();
}

void DLLRestApi::nameFromEngine(QString name){

    emit nameToExe(name);
 }


