#include "app_theme.hpp"

#ifdef QT_DEBUG
    #include "logger.hpp"
#endif


AppTheme* AppTheme::m_Instance = Q_NULLPTR;

// Constructors, Initializers, ShutDown, Destructor
// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]

AppTheme::AppTheme(QObject *parent, const QString& name)
    : QObject{parent}
    , m_Colors(QVariantMap{})
    , m_Themes(QVariantMap{})
{
    this->setObjectName(name);

#ifdef QT_DEBUG
    QString message("Call to Constructor");

    logger::log(logger::LOG_LEVEL::DEBUG, this->objectName(), Q_FUNC_INFO, message);
#endif
}

AppTheme::~AppTheme()
{
#ifdef QT_DEBUG
    QString message("Call to Destructor");

    logger::log(logger::LOG_LEVEL::DEBUG, this->objectName(), Q_FUNC_INFO, message);
#endif
}

AppTheme *AppTheme::qmlInstance(QQmlEngine *engine, QJSEngine *scriptEngine)
{
    Q_UNUSED(engine);
    Q_UNUSED(scriptEngine);

    if (!m_Instance)
    {
        m_Instance = new AppTheme();
    }

    return(m_Instance);
}

AppTheme *AppTheme::cppInstance(QObject *parent)
{
    if(m_Instance)
    {
        return(qobject_cast<AppTheme *>(AppTheme::m_Instance));
    }

    auto instance = new AppTheme(parent);
    m_Instance = instance;
    return(instance);
}

// In Qt, this won't be neccessary since we have parent-child memory management.
void AppTheme::ShutDown()
{
    delete (m_Instance);
    m_Instance = Q_NULLPTR;
}

// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]





// PUBLIC Methods
// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]

void AppTheme::addTheme(const QString &filePath)
{
    QFile file(filePath);
    QFileInfo fileInfo(file);


    if (!file.exists())
    {
#ifdef QT_DEBUG
        QString message("File does not exist: %1");

        message = message.arg(
            fileInfo.absolutePath()
        );

        logger::log(logger::LOG_LEVEL::DEBUG, this->objectName(), Q_FUNC_INFO, message);
#endif

        return;
    }

    bool fileTypeIsJson = (fileInfo.suffix().compare("json", Qt::CaseInsensitive) == 0);

    if (!fileTypeIsJson)
    {
#ifdef QT_DEBUG
        QString message("File is not of JSON type! \n File Name: %1 \n Full Path: %2");

        message = message.arg(
            fileInfo.fileName(),
            fileInfo.absolutePath()
        );

        logger::log(logger::LOG_LEVEL::DEBUG, this->objectName(), Q_FUNC_INFO, message);
#endif

        return;
    }


    // You can add more rules for fileName here using Regex.

    m_Themes.insert(fileInfo.baseName(), filePath);

    emit themesChanged();
}

void AppTheme::addThemes(const QString &rootFolderPath)
{
    QDirIterator iterator(
        rootFolderPath,               // Start location
        {"*.json"},                   // File name pattern
        QDir::Files,                  // Filter for files
        QDirIterator::Subdirectories  // Perform recursively
    );

    while (iterator.hasNext())
    {
        addTheme(
            iterator.next()
        );
    }
}

void AppTheme::loadColorsFromTheme(const QString &themeKey)
{
    QVariantMap map;
    QString filePath = getThemes().value(themeKey).toString();


    cacheTheme(themeKey);


    QFile themeFile(
        filePath
    );

    QFile placeholderFile(
        "./resources/json/placeholder.json"
    );


    if (!themeFile.open(QIODevice::ReadOnly))
    {
#ifdef QT_DEBUG
        QString message("Could not open JSON file: %1");

        message = message.arg(
            QFileInfo(themeFile).filePath()
        );

        logger::log(logger::LOG_LEVEL::DEBUG, this->objectName(), Q_FUNC_INFO, message);
#endif

        return;
    }

    if (!placeholderFile.open(QIODevice::ReadOnly))
    {
#ifdef QT_DEBUG
        QString message("Could not open Placeholder JSON file: %1");

        message = message.arg(
            QFileInfo(placeholderFile).filePath()
        );

        logger::log(logger::LOG_LEVEL::DEBUG, this->objectName(), Q_FUNC_INFO, message);
#endif

        return;
    }


    QByteArray themeJsonData = themeFile.readAll();
    themeFile.close();

    QByteArray placeholderJsonData = placeholderFile.readAll();
    placeholderFile.close();


    QString resolvedJson = resolvePlaceholders(
        themeJsonData,
        placeholderJsonData
    );


    QJsonDocument jsonDoc = QJsonDocument::fromJson(resolvedJson.toUtf8());
    QJsonObject rootObject = jsonDoc.object();

    for (auto it = rootObject.begin(); it != rootObject.end(); ++it)
    {
        map[it.key()] = it.value().toString();
    }

    setColors(map);
}

// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]





// PRIVATE Methods
// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]

void AppTheme::cacheTheme(const QString &themeKey)
{
    QSettings settings(

        "./cache/theme.ini",
        QSettings::Format::IniFormat
    );

    settings.setValue(

        "lastUsedThemeKey",
        themeKey
    );

    settings.sync();
}

QString AppTheme::resolvePlaceholders(const QString &themeJson, const QString &placeholderJson)
{
    QJsonObject themeJsonObject = QJsonDocument::fromJson(themeJson.toUtf8()).object();
    QJsonObject placeholderJsonObject = QJsonDocument::fromJson(placeholderJson.toUtf8()).object();


    QString resolvedThemeString = themeJson;


    // Regex pattern matches placeholders with the following pattern:
    // "Color_<name>_numbers[0-9]";
    static const QRegularExpression placeholderRegex("\"(Color_[a-zA-Z]*_[0-9]+)\"");

    QRegularExpressionMatchIterator iter = placeholderRegex.globalMatch(themeJson);


    while (iter.hasNext())
    {
        QRegularExpressionMatch match = iter.next();

        QString placeholder = match.captured(1);

        if (placeholderJsonObject.contains(placeholder))
        {
            QJsonValue replacementValue = placeholderJsonObject.value(placeholder);

            resolvedThemeString.replace(

                placeholder,
                replacementValue.toString()
            );
        }

        else
        {
#ifdef QT_DEBUG
            QString message("Placeholder: %1 not found!");

            message = message.arg(
                placeholder
            );

            logger::log(logger::LOG_LEVEL::DEBUG, this->objectName(), Q_FUNC_INFO, message);
#endif
        }
    }

    return (resolvedThemeString);
}

// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]





// PUBLIC Getters
// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]

QVariantMap AppTheme::getThemes() const
{
    return (m_Themes);
}

QVariantMap AppTheme::getColors() const
{
    return (m_Colors);
}

QString AppTheme::getCachedTheme() const
{
    QSettings settings(

        "./cache/theme.ini",
        QSettings::Format::IniFormat
    );

    QVariant returnValue = settings.value("lastUsedThemeKey");


    if(returnValue.isNull())
    {
        return "";
    }


    return (returnValue.toString());
}

// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]





// PRIVATE Setters
// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]

void AppTheme::setColors(const QVariantMap &newColors)
{
    if (m_Colors == newColors)
    {
        return;
    }

    m_Colors = newColors;
    emit colorsChanged();
}

// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]
