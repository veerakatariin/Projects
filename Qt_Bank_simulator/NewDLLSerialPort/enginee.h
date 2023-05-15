#ifndef ENGINEE_H
#define ENGINEE_H

#include <QObject>
#include <QtSerialPort/QtSerialPort>
#include <QtSerialPort/QSerialPortInfo>
#include <QString>
#include <QList>
#include <QDebug>


class Enginee : public QObject{
    Q_OBJECT

public:
    Enginee(QObject * parent = nullptr);
    ~Enginee();
    void open();
    void info();

private:
    QSerialPort *PSerialPort;
    QSerialPortInfo *PSerialPortInfo;
    QString cardnumber;

signals:
    void sendToInterface(QString);
};

#endif // ENGINEE_H
