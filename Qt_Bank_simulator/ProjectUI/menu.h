#ifndef MENU_H
#define MENU_H

#include <QDialog>
#include "engine.h"
#include "dllrestapi.h"

namespace Ui {
class Menu;
}

class Menu : public QDialog
{
    Q_OBJECT

public:
    explicit Menu(QWidget *parent = nullptr);
    ~Menu();

    void getid(QString);


private slots:
    void on_pushButton_tili_clicked();

    void on_pushButton_nosto_clicked();

    void on_pushButton_saldo_clicked();

    void on_pushButton_siirto_clicked();

    void on_pushButton_talletus_clicked();

    void on_pushButton_ulos_clicked();


private:
    Ui::Menu *ui;
    QTimer *timer = new QTimer(this);
    DLLRestApi *manager;

    QString cardid;

public slots:
    void getCustomer(QString);
};

#endif // MENU_H
