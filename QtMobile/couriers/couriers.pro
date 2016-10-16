QT += qml quick quickcontrols2 network widgets

CONFIG += c++11

SOURCES += main.cpp \
    eventhandler.cpp \
    user.cpp \
    httpnetwork.cpp

RESOURCES += \
    qml.qrc

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    eventhandler.h \
    user.h \
    httpnetwork.h
