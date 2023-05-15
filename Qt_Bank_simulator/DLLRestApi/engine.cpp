#include "engine.h"

engine::engine(QObject *parent): QObject (parent){
}

engine::~engine(){
    delete manager;
    manager = nullptr;
    delete manager2;
    manager2 = nullptr;
    delete manager3;
    manager3 = nullptr;
    delete manager4;
    manager4 = nullptr;
    delete saldoReply;
    saldoReply = nullptr;
    delete customerReply;
    customerReply = nullptr;
    delete actionsReply;
    actionsReply = nullptr;
    delete cardRepy;
    cardRepy =nullptr;
    delete addedActionReply;
    addedActionReply = nullptr;
}

void engine::makeSaldoRequest(QString id){

      QString site_url="http://localhost:3000/tili/1";
      QString credentials="automaatti1:raha123";
      QNetworkRequest request((site_url));
      request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
      QByteArray data = credentials.toLocal8Bit().toBase64();
      QString headerData = "Basic " + data;
      request.setRawHeader( "Authorization", headerData.toLocal8Bit());

      manager = new QNetworkAccessManager(this);
      connect(manager, SIGNAL(finished (QNetworkReply*)),
                    this, SLOT(saldoReplySlot(QNetworkReply*)));
      saldoReply = manager->get(request);

}

  void engine::saldoReplySlot(QNetworkReply *saldoreply){
    QByteArray response_data=saldoreply->readAll();
    QJsonDocument json_doc=QJsonDocument::fromJson(response_data);

   QJsonObject json_obj=json_doc.object();
   QString saldo=QString::number((json_obj["tilin_saldo"].toInt()));

    emit sendSaldoToInterface(saldo);

    manager->deleteLater();
    saldoreply->deleteLater();
    saldoReply->deleteLater();

}

  void engine::makeCardRequest(QString id){

      //cardid laitetaan site_urlin perään jotta saadaan oikea tieto

        QString site_url="http://localhost:3000/kortti/1";
        QString credentials="automaatti1:raha123";
        QNetworkRequest request((site_url));
        request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
        QByteArray data = credentials.toLocal8Bit().toBase64();
        QString headerData = "Basic " + data;
        request.setRawHeader( "Authorization", headerData.toLocal8Bit());

        manager5 = new QNetworkAccessManager(this);
        connect(manager5, SIGNAL(finished (QNetworkReply*)),
                      this, SLOT(cardReplySlot(QNetworkReply*)));

        cardRepy = manager5->get(request);

  }

  void engine::cardReplySlot(QNetworkReply *cardreply){
      QByteArray response_data=cardreply->readAll();
      QJsonDocument json_doc=QJsonDocument::fromJson(response_data);

      QJsonObject json_obj=json_doc.object();
      QString card=json_obj["pin_koodi"].toString();
      QString cardnumber=json_obj["kortinnumero"].toString();

      emit sendCardToInterface(card);
      emit sendCardnumberToInterface(cardnumber);



      manager5->deleteLater();
      cardRepy->deleteLater();
      cardreply->deleteLater();
  }


 void engine::makeCustomerRequest(QString id){
      QString site_url="http://localhost:3000/asiakas/1";
      QString credentials="automaatti1:raha123";
      QNetworkRequest request((site_url));
      request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
      QByteArray data = credentials.toLocal8Bit().toBase64();
      QString headerData = "Basic " + data;
      request.setRawHeader( "Authorization", headerData.toLocal8Bit());

      manager2 = new QNetworkAccessManager(this);
      connect(manager2, SIGNAL(finished (QNetworkReply*)),
              this, SLOT(customerReplySlot(QNetworkReply*)));
      customerReply = manager2->get(request);

  }

    void engine::customerReplySlot(QNetworkReply *customerreply){
      QByteArray response_data=customerreply->readAll();
      QJsonDocument json_doc=QJsonDocument::fromJson(response_data);

      QJsonObject json_obj=json_doc.object();
      QString person=json_obj["nimi"].toString()+" "+
              json_obj["lahiosoite"].toString()+" "+ json_obj["puhelinnumero"].toString()+ "\r\n";
      QString name=json_obj["nimi"].toString();

      emit sendCustomerToInterface(person);
      emit sendNameToInterface(name);

      manager2->deleteLater();
      customerReply->deleteLater();
      customerreply->deleteLater();
}

    void engine::makeActionsRequest(QString id){
        QString site_url="http://localhost:3000/action/1";
        QString credentials="automaatti1:raha123";
        QNetworkRequest request((site_url));
        request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
        QByteArray data = credentials.toLocal8Bit().toBase64();
        QString headerData = "Basic " + data;
        request.setRawHeader( "Authorization", headerData.toLocal8Bit());

        manager3 = new QNetworkAccessManager(this);

        connect(manager3, SIGNAL(finished (QNetworkReply*)),
                this, SLOT(actionsReplySlot(QNetworkReply*)));

        actionsReply = manager3->get(request);
}

    void engine::actionsReplySlot(QNetworkReply *actionreply){
        QByteArray response_data=actionsReply->readAll();
        qDebug() << response_data;
        QJsonDocument json_doc=QJsonDocument::fromJson(response_data);
        QJsonArray json_array = json_doc.array();
        QString action;
        QJsonObject json_obj=json_doc.object();

        foreach (const QJsonValue &value, json_array) {
        QJsonObject json_obj = value.toObject();

        for(id_action = 0; id_action < 10; id_action++){
            action=QString::number(json_obj["amount"].toInt())+
                    " " + json_obj["date"].toString()+ " " + json_obj["action_type"].toString();

             emit sendActionsToInterface(action);
        }

        }

        //QString action=QString::number((json_obj["tilin_saldo"].toInt()))+" "
             // +json_obj["date"].toString()+" "+ json_obj["action_type"].toString();;

        manager3->deleteLater();
        actionsReply->deleteLater();
        actionreply->deleteLater();

}

    void engine::postAction(QString amount, QString id){

        QString type ="pano";
        QJsonObject json;
        json.insert("id", id);
        json.insert("amount", amount);
        json.insert("action_type", type);

        QString site_url="http://localhost:3000/action/money_action/1";
        QString credentials="automaatti1:raha123";
        QNetworkRequest request((site_url)); request.setHeader(QNetworkRequest::ContentTypeHeader,
        "application/json");
        QByteArray data = credentials.toLocal8Bit().toBase64();
        QString headerData = "Basic " + data;
        request.setRawHeader( "Authorization", headerData.toLocal8Bit() );
        manager4 = new QNetworkAccessManager(this);

        connect(manager4, SIGNAL(finished (QNetworkReply*)),
                this, SLOT(postActionSlot(QNetworkReply*)));

        addedActionReply = manager4->post(request, QJsonDocument(json).toJson());
}

    void engine::postActionSlot(QNetworkReply *reply){

        QByteArray response_data=reply->readAll();
        emit depositToInterface();
}

    void engine::postWithdrawal(QString amount, QString id){

        QString type = "otto";
        QJsonObject json;
        json.insert("id", id);
        json.insert("amount", amount);
        json.insert("action_type", type);

        QString site_url="http://localhost:3000/action/money_action/1";
        QString credentials="automaatti1:raha123";
        QNetworkRequest request((site_url)); request.setHeader(QNetworkRequest::ContentTypeHeader,
        "application/json");
        QByteArray data = credentials.toLocal8Bit().toBase64();
        QString headerData = "Basic " + data;
        request.setRawHeader( "Authorization", headerData.toLocal8Bit() );
        manager4 = new QNetworkAccessManager(this);

        connect(manager4, SIGNAL(finished (QNetworkReply*)),
                this, SLOT(postWithdrawalSlot(QNetworkReply*)));

        addedActionReply = manager4->post(request, QJsonDocument(json).toJson());
}

    void engine::postWithdrawalSlot(QNetworkReply *reply){

        QByteArray response_data=reply->readAll();
        emit withdrawalToInterface();

}


    void engine::postManyActions(QString id, QString idaction){

        QJsonObject json;
        json.insert("id", id);
        json.insert("id_action", idaction);

        QString site_url="http://localhost:3000/action/money_action/";
        QString credentials="automaatti1:raha123";
        QNetworkRequest request((site_url)); request.setHeader(QNetworkRequest::ContentTypeHeader,
        "application/json");
        QByteArray data = credentials.toLocal8Bit().toBase64();
        QString headerData = "Basic " + data;
        request.setRawHeader( "Authorization", headerData.toLocal8Bit() );
        manager = new QNetworkAccessManager(this);
        qDebug() << "dllaaä";

        connect(manager, SIGNAL(finished (QNetworkReply*)),
                this, SLOT(postManyActionsSlot(QNetworkReply*)));

        actionsReply = manager->post(request, QJsonDocument(json).toJson());
}

    void engine::postManyActionsSlot(QNetworkReply *reply){

       QByteArray response_data=reply->readAll();
       QJsonDocument json_doc = QJsonDocument::fromJson(response_data);

       QJsonObject json_obj=json_doc.object();
       QString action=QString::number(json_obj["amount"].toInt())+","+
               json_obj["date"].toString()+json_obj["action_type"].toString();

       emit manyActionsToInterface(action);
       }
