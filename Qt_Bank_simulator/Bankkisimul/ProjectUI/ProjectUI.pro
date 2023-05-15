QT       += core gui
QT       +=network

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

CONFIG += c++11

# The following define makes your compiler emit warnings if you use
# any Qt feature that has been marked deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
    addrecipient.cpp \
    main.cpp \
    mainwindow.cpp \
    menu.cpp \
    nosto.cpp \
    nostofail.cpp \
    nostosuccess.cpp \
    saldo.cpp \
    siirto.cpp \
    talletus.cpp \
    talletussuccess.cpp \
    tilitapahtuma.cpp

HEADERS += \
    addrecipient.h \
    mainwindow.h \
    menu.h \
    nosto.h \
    nostofail.h \
    nostosuccess.h \
    saldo.h \
    siirto.h \
    talletus.h \
    talletussuccess.h \
    tilitapahtuma.h

FORMS += \
    addrecipient.ui \
    mainwindow.ui \
    menu.ui \
    nosto.ui \
    nostofail.ui \
    nostosuccess.ui \
    saldo.ui \
    siirto.ui \
    talletus.ui \
    talletussuccess.ui \
    tilitapahtuma.ui

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

DISTFILES +=

win32:CONFIG(release, debug|release): LIBS += -L$$PWD/../build-DLLRestApi-Desktop_Qt_5_15_0_MinGW_32_bit-Debug/release/ -lDLLRestApi
else:win32:CONFIG(debug, debug|release): LIBS += -L$$PWD/../build-DLLRestApi-Desktop_Qt_5_15_0_MinGW_32_bit-Debug/debug/ -lDLLRestApi
else:unix: LIBS += -L$$PWD/../build-DLLRestApi-Desktop_Qt_5_15_0_MinGW_32_bit-Debug/ -lDLLRestApi

INCLUDEPATH += $$PWD/../DLLRestApi
DEPENDPATH += $$PWD/../DLLRestApi

win32:CONFIG(release, debug|release): LIBS += -L$$PWD/../build-NewDLLSerialPort-Desktop_Qt_5_15_0_MinGW_32_bit-Debug/release/ -lNewDLLSerialPort
else:win32:CONFIG(debug, debug|release): LIBS += -L$$PWD/../build-NewDLLSerialPort-Desktop_Qt_5_15_0_MinGW_32_bit-Debug/debug/ -lNewDLLSerialPort
else:unix: LIBS += -L$$PWD/../build-NewDLLSerialPort-Desktop_Qt_5_15_0_MinGW_32_bit-Debug/ -lNewDLLSerialPort

INCLUDEPATH += $$PWD/../NewDLLSerialPort
DEPENDPATH += $$PWD/../NewDLLSerialPort


win32: LIBS += -L$$PWD/../build-DLLPinCode-Desktop_Qt_5_15_0_MinGW_32_bit-Debug/debug/ -lDLLPinCode

INCLUDEPATH += $$PWD/../DLLPinCode
DEPENDPATH += $$PWD/../DLLPinCode
