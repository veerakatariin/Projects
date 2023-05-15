#ifndef TALLETUS_H
#define TALLETUS_H

#include <QDialog>
#include "dllrestapi.h"

namespace Ui {
class Talletus;
}

class Talletus : public QDialog
{
    Q_OBJECT

public:
    explicit Talletus(QWidget *parent = nullptr);
    ~Talletus();
    void getcardid(QString);


private slots:
    void on_pushButton_clicked();

    void on_pushButton_8_clicked();

    void on_pushButton_100_clicked();

    void on_pushButton_40_clicked();

    void on_pushButton_200_clicked();

    void on_pushButton_60_clicked();

    void on_pushButton_600_clicked();

    void on_pushButton_20_clicked();

private:
    Ui::Talletus *ui;
    engine *enkine;
    DLLRestApi *manager;
    QTimer *timer = new QTimer;

    QString cardid;
    QString amount;


public slots:
    void depositFromEngine();
    void saldoFromInterface(QString);
    void customerFromInterface(QString);



};

#endif // TALLETUS_H
