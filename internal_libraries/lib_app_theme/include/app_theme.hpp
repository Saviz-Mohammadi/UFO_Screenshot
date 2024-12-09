#ifndef APPTHEME_H
#define APPTHEME_H

#include <QFile>
#include <QFileInfo>
#include <QDirIterator>
#include <QGuiApplication>
#include <QJsonArray>
#include <QJsonDocument>
#include <QJsonObject>
#include <QObject>
#include <QQmlEngine>
#include <QRegularExpression>
#include <QSettings>
#include <QVariantMap>


class AppTheme : public QObject
{
    Q_OBJECT
    Q_DISABLE_COPY_MOVE(AppTheme) // Needed for Singleton pattern.

    // Q_PROPERTY;
    Q_PROPERTY(QVariantMap themes READ getThemes NOTIFY themesChanged FINAL)
    Q_PROPERTY(QVariantMap colors READ getColors NOTIFY colorsChanged FINAL)

    // Constructors, Initializers, ShutDown, Destructor
public:
    explicit AppTheme(QObject *parent = Q_NULLPTR, const QString& name = "No name");
    ~AppTheme();

    static AppTheme *qmlInstance(QQmlEngine *engine, QJSEngine *scriptEngine);
    static AppTheme *cppInstance(QObject *parent = Q_NULLPTR);

    // No need for Init().
    static void ShutDown();

    // Fields;
private:
    static AppTheme *m_Instance;
    QVariantMap m_Themes; // Pairs of file names and their paths.
    QVariantMap m_Colors; // Pairs of color names and their values.

    // Signals;
signals:
    void themesChanged();
    void colorsChanged();

    // PUBLIC Methods;
public:
    Q_INVOKABLE void addTheme(const QString &filePath);
    Q_INVOKABLE void addThemes(const QString &rootFolderPath);
    Q_INVOKABLE void loadColorsFromTheme(const QString &themeKey);

    // PRIVATE Methods;
private:
    void cacheTheme(const QString &themeKey);
    QString resolvePlaceholders(const QString &themeJson, const QString &placeholderJson);

    // PUBLIC Getters
public:
    QVariantMap getThemes() const;
    QVariantMap getColors() const;
    Q_INVOKABLE QString getCachedTheme() const;

    // PRIVATE Setters
private:
    void setColors(const QVariantMap &newColors);
};

#endif // APPTHEME_H
