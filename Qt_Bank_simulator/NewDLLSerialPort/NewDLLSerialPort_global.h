#ifndef NEWDLLSERIALPORT_GLOBAL_H
#define NEWDLLSERIALPORT_GLOBAL_H

#include <QtCore/qglobal.h>

#if defined(NEWDLLSERIALPORT_LIBRARY)
#  define NEWDLLSERIALPORT_EXPORT Q_DECL_EXPORT
#else
#  define NEWDLLSERIALPORT_EXPORT Q_DECL_IMPORT
#endif

#endif // NEWDLLSERIALPORT_GLOBAL_H
