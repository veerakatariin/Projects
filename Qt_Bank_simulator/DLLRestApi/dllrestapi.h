#ifndef DLLRESTAPI_H
#define DLLRESTAPI_H

#include "DLLRestApi_global.h"
#include "engine.h"

class DLLRESTAPI_EXPORT DLLRestApi : public QObject

{
    Q_OBJECT
public:
    DLLRestApi(QObject *parent = nullptr);
    ~DLLRestApi();
    void getSaldo(QString);
    void getCustomer(QString);
    void getActions(QString);
    void getCard(QString);

    void getNewWithdrawal(QString, QString);
    void getNewAction(QString, QString);
    void getManyActions(QString, QString);

private:
   engine * pengine;

public slots:
   void saldoFromEngine(QString);
   void cardFromEngine(QString);
   void customerFromEngine(QString);
   void actionsFromEngine(QString);
   void cardnumberFromEngine(QString);
   void nameFromEngine(QString);

   void depositFromEngine();
   void withdrawalFromEngine();
   void manyActionsFromEngine(QString);


signals:
   void saldoToExe(QString);
   void cardToExe(QString);
   void cardnumberToExe(QString);
   void actionsToExe(QString);
   void customerToExe(QString);
   void depositToExe();
   void nameToExe(QString);

   void withdrawalToExe();
   void manyActionsToExe(QString);




};

#endif // DLLRESTAPI_H
