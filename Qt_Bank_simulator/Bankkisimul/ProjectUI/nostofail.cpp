#include "nostofail.h"
#include "ui_nostofail.h"
#include "menu.h"

nostofail::nostofail(QWidget *parent) :
    QDialog(parent),
    ui(new Ui::nostofail)
{
    ui->setupUi(this);
    connect(timer, SIGNAL(timeout()), this, SLOT(on_pushButton_clicked()));
    //timer->start(10000);
}

nostofail::~nostofail()
{
    delete ui;
    delete timer;
    timer = nullptr;
}

//sulje nappi josta pääsee menuun
void nostofail::on_pushButton_clicked()
{
    this->close();

    Menu kir;
    kir.setModal(true);
    kir.exec();

}
