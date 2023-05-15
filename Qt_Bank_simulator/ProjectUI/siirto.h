#ifndef SIIRTO_H
#define SIIRTO_H

#include <QDialog>
#include <QTimer>
#include "dllrestapi.h"
#include "addrecipient.h"

namespace Ui {
class Siirto;
}

class Siirto : public QDialog
{
    Q_OBJECT

public:
    explicit Siirto(QWidget *parent = nullptr);
    ~Siirto();
    void getcardid(QString);

private slots:
    void on_pushButton_clicked();

    void on_pushButton_2_clicked();

    void on_pushButton_3_clicked();

    void on_pushButton_4_clicked();

    void on_pushButton_5_clicked();

    void on_pushButton_6_clicked();

    void on_pushButton_7_clicked();

    void on_pushButton_8_clicked();

    void on_pushButton_9_clicked();

    void on_pushButton_10_clicked();

    void on_pushButton_11_clicked();

    void on_pushButton_12_clicked();

    void on_pushButton_13_clicked();

    void on_pushButton_14_clicked();

    void on_pushButton_15_clicked();

private:
    Ui::Siirto *ui;
    QTimer *timer = new QTimer(this);
    DLLRestApi *manager;
    addRecipient *move;

    QString number;
    QString accountnumber;
    QString recipientid;
    QString cardid;


public slots:
    void getSaldo(QString);
    void getCustomer(QString);

};

#endif // SIIRTO_H
