#include "logger.hpp"


// Methods
// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]

void logger::log(LOG_LEVEL level, const QString &objectName, const QString &functionInformation, const QString &message, const QChar &delimiter, quint8 delimiterCount)
{
    if(level == logger::LOG_LEVEL::DEBUG)
    {
        logger::logDebug(objectName, functionInformation, message, delimiter, delimiterCount);

        return;
    }

    if(level == logger::LOG_LEVEL::INFO)
    {
        logger::logDebug(objectName, functionInformation, message, delimiter, delimiterCount);

        return;
    }

    if(level == logger::LOG_LEVEL::WARNING)
    {
        logger::logWarning(objectName, functionInformation, message, delimiter, delimiterCount);

        return;
    }

    if(level == logger::LOG_LEVEL::CRITICAL)
    {
        logger::logCritical(objectName, functionInformation, message, delimiter, delimiterCount);

        return;
    }

    if(level == logger::LOG_LEVEL::FATAL)
    {
        logger::logFatal(objectName, functionInformation, message, delimiter, delimiterCount);

        return;
    }
}

// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]





// STATIC Methods
// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]

void logger::logDebug(const QString &objectName, const QString &functionInformation, const QString &message, const QChar &delimiter, quint8 delimiterCount)
{
    QString logOutput;
    QTextStream stream(&logOutput);

    stream  << "\n" << "[DEBUG]"
            << "\n" << QString(delimiter).repeated(delimiterCount)
            << "\n" << ">> Object Name : " << objectName
            << "\n" << ">> Function    : " << functionInformation
            << "\n" << ">> Message     : " << "\n"
            << "\n" << message
            << "\n" << QString(delimiter).repeated(delimiterCount) << "\n";

    qDebug().noquote() << logOutput.toUtf8().constData();
}

void logger::logInfo(const QString &objectName, const QString &functionInformation, const QString &message, const QChar &delimiter, quint8 delimiterCount)
{
    QString logOutput;
    QTextStream stream(&logOutput);

    stream  << "\n" << "[INFO]"
            << "\n" << QString(delimiter).repeated(delimiterCount)
            << "\n" << ">> Object Name : " << objectName
            << "\n" << ">> Function    : " << functionInformation
            << "\n" << ">> Message     : " << "\n"
            << "\n" << message
            << "\n" << QString(delimiter).repeated(delimiterCount) << "\n";

    qInfo().noquote() << logOutput.toUtf8().constData();
}

void logger::logWarning(const QString &objectName, const QString &functionInformation, const QString &message, const QChar &delimiter, quint8 delimiterCount)
{
    QString logOutput;
    QTextStream stream(&logOutput);

    stream  << "\n" << "[WARNING]"
            << "\n" << QString(delimiter).repeated(delimiterCount)
            << "\n" << ">> Object Name : " << objectName
            << "\n" << ">> Function    : " << functionInformation
            << "\n" << ">> Message     : " << "\n"
            << "\n" << message
            << "\n" << QString(delimiter).repeated(delimiterCount) << "\n";

    qWarning().noquote() << logOutput.toUtf8().constData();
}

void logger::logCritical(const QString &objectName, const QString &functionInformation, const QString &message, const QChar &delimiter, quint8 delimiterCount)
{
    QString logOutput;
    QTextStream stream(&logOutput);

    stream  << "\n" << "[CRITICAL]"
            << "\n" << QString(delimiter).repeated(delimiterCount)
            << "\n" << ">> Object Name : " << objectName
            << "\n" << ">> Function    : " << functionInformation
            << "\n" << ">> Message     : " << "\n"
            << "\n" << message
            << "\n" << QString(delimiter).repeated(delimiterCount) << "\n";

    qCritical().noquote() << logOutput.toUtf8().constData();
}

void logger::logFatal(const QString &objectName, const QString &functionInformation, const QString &message, const QChar &delimiter, quint8 delimiterCount)
{
    QString logOutput;
    QTextStream stream(&logOutput);

    stream  << "\n" << "[FATAL]"
            << "\n" << QString(delimiter).repeated(delimiterCount)
            << "\n" << ">> Object Name : " << objectName
            << "\n" << ">> Function    : " << functionInformation
            << "\n" << ">> Message     : " << "\n"
            << "\n" << message
            << "\n" << QString(delimiter).repeated(delimiterCount) << "\n";

    qFatal().noquote() << logOutput.toUtf8().constData();
}

// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]
