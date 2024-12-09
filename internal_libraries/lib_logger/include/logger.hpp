#ifndef LOGGER_H
#define LOGGER_H

#include <QDebug>
#include <QChar>
#include <QStringList>
#include <QString>
#include <QTextStream>
#include <QtTypes>

// At the moment, I fail to see why we need this to be a Class. So, for now I use normal C-style architecture.

namespace logger
{
// Enums
enum class LOG_LEVEL {
    DEBUG = 0,
    INFO = 1,
    WARNING = 2,
    CRITICAL = 3,
    FATAL = 4
};

// Methods
void log(
    LOG_LEVEL level,
    const QString &objectName = "No name",
    const QString &functionInformation = "No info",
    const QString &message = "No message",
    const QChar &delimiter = '-',
    quint8 delimiterCount = 80
    );

// STATIC Methods
static void logDebug(
    const QString &objectName = "No name",
    const QString &functionInformation = "No info",
    const QString &message = "No message",
    const QChar &delimiter = '-',
    quint8 delimiterCount = 80
    );

static void logInfo(
    const QString &objectName = "No name",
    const QString &functionInformation = "No info",
    const QString &message = "No message",
    const QChar &delimiter = '-',
    quint8 delimiterCount = 80
    );

static void logWarning(
    const QString &objectName = "No name",
    const QString &functionInformation = "No info",
    const QString &message = "No message",
    const QChar &delimiter = '-',
    quint8 delimiterCount = 80
    );

static void logCritical(
    const QString &objectName = "No name",
    const QString &functionInformation = "No info",
    const QString &message = "No message",
    const QChar &delimiter = '-',
    quint8 delimiterCount = 80
    );

static void logFatal(
    const QString &objectName = "No name",
    const QString &functionInformation = "No info",
    const QString &message = "No message",
    const QChar &delimiter = '-',
    quint8 delimiterCount = 80
    );
}


#endif // LOGGER_H
