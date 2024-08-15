#include "app_theme.hpp"

AppTheme* AppTheme::m_Instance = nullptr;

// Constructors, Initializers, Destructor
// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]

AppTheme::AppTheme(QObject *parent, const QString& name)
    : QObject{parent}
    , m_Colors(QVariantMap{})
    , m_Themes(QVariantMap{})
{
    this->setObjectName(name);



// Debugging
#ifdef QT_DEBUG
    qDebug() << "\n**************************************************\n"
             << "* Object Name :" << this->objectName()  << "\n"
             << "* Function    :" << __FUNCTION__        << "\n"
             << "* Message     : Call to Constructor"
             << "\n**************************************************\n\n";
#endif
}

AppTheme::~AppTheme()
{



// Debugging
#ifdef QT_DEBUG
    qDebug() << "\n**************************************************\n"
             << "* Object Name :" << this->objectName()  << "\n"
             << "* Function    :" << __FUNCTION__        << "\n"
             << "* Message     : Call to Destructor"
             << "\n**************************************************\n\n";
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
// Debugging
#ifdef QT_DEBUG
        qDebug() << "\n**************************************************\n"
                 << "* Object Name :" << this->objectName()  << "\n"
                 << "* Function    :" << __FUNCTION__        << "\n"
                 << "* Message     : File does not exist: "  << fileInfo.absolutePath()
                 << "\n**************************************************\n\n";
#endif



        return;
    }

    bool fileTypeIsJson = (fileInfo.suffix().compare("json", Qt::CaseInsensitive) == 0);

    if (!fileTypeIsJson)
    {
// Debugging
#ifdef QT_DEBUG
        qDebug() << "\n**************************************************\n"
                 << "* Object Name :" << this->objectName()     << "\n"
                 << "* Function    :" << __FUNCTION__           << "\n"
                 << "* Message     : File is not a JSON file! " << fileInfo.fileName()
                 << "* Full Path   : " << fileInfo.absolutePath()
                 << "\n**************************************************\n\n";
#endif



        return;
    }



    // You can add more rules for fileName here using Regex.



// Debugging
#ifdef QT_DEBUG
    qDebug() << "\n**************************************************\n"
             << "* Object Name :" << this->objectName()     << "\n"
             << "* Function    :" << __FUNCTION__           << "\n"
             << "* Message     : JSON file found! " << fileInfo.fileName()
             << "\n**************************************************\n\n";
#endif



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
// Debugging
#ifdef QT_DEBUG
        qDebug() << "\n**************************************************\n"
                 << "* Object Name :" << this->objectName()      << "\n"
                 << "* Function    :" << __FUNCTION__            << "\n"
                 << "* Message     : Could not open JSON file: " << QFileInfo(themeFile).filePath()
                 << "\n**************************************************\n\n";
#endif



        return;
    }

    if (!placeholderFile.open(QIODevice::ReadOnly))
    {
// Debugging
#ifdef QT_DEBUG
        qDebug() << "\n**************************************************\n"
                 << "* Object Name :" << this->objectName()                  << "\n"
                 << "* Function    :" << __FUNCTION__                        << "\n"
                 << "* Message     : Could not open Placeholder JSON file: " << QFileInfo(placeholderFile).filePath()
                 << "\n**************************************************\n\n";
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
// Debugging
#ifdef QT_DEBUG
            qDebug() << "\n**************************************************\n\n"
                     << "* Object Name :" << this->objectName()        << "\n"
                     << "* Function    :" << __FUNCTION__              << "\n"
                     << "* Message     : Placeholder: " << placeholder << "not found!"
                     << "\n**************************************************\n\n";
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