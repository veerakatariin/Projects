#ifndef PINCODEENGINE_H
#define PINCODEENGINE_H

#include <QDialog>
#include <QDebug>
#include <QJsonDocument>

namespace Ui {
class pincodeEngine;
}

class pincodeEngine : public QDialog
{
    Q_OBJECT

public:
    explicit pincodeEngine(QWidget *parent = nullptr);
    ~pincodeEngine();
    void insertPin();
    QString returnValueToInterface();

private:
    Ui::pincodeEngine *ui;
    int number;
    QString pin;
    QString choppedText;
    QString pincode;

private slots:
    void on_B1_clicked();
    void on_B2_clicked();
    void on_B3_clicked();
    void on_B4_clicked();
    void on_B5_clicked();
    void on_B6_clicked();
    void on_B7_clicked();
    void on_B8_clicked();
    void on_B9_clicked();
    void on_B0_clicked();
    void on_OK_clicked();
    void on_Cancel_clicked();
};

#endif // PINCODEENGINE_H
