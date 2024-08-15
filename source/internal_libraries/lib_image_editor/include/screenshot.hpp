#ifndef SCREENSHOT_H
#define SCREENSHOT_H

#include <QFile>
#include <QFileInfo>
#include <QPixmap>
#include <QGuiApplication>
#include <QJsonArray>
#include <QJsonDocument>
#include <QJsonObject>
#include <QObject>
#include <QQmlEngine>
#include <QVariantList>

class Screenshot : public QObject
{
    Q_OBJECT
    Q_DISABLE_COPY_MOVE(Screenshot) // Needed for Singleton pattern.

    // Q_PROPERTY;
    Q_PROPERTY(QPixmap screenshot READ getScreenshot NOTIFY screenshotChanged)

    // Constructors, Initializers, Destructor
public:
    explicit Screenshot(QObject *parent = nullptr, const QString& name = "No name");
    ~Screenshot();

    static Screenshot *qmlInstance(QQmlEngine *engine, QJSEngine *scriptEngine);
    static Screenshot *cppInstance(QObject *parent = nullptr);

    QPixmap getScreenshot() const
    {
        return (m_Screenshot);
    }

    void setScreenshot(const QPixmap &newScreenshot)
    {
        if (m_Screenshot == newScreenshot)
        {
            return;
        }

        m_Screenshot = newScreenshot;

        emit screenshotChanged();
    }

    // Fields;
private:
    static Screenshot *m_Instance;
    QPixmap m_Screenshot;

    // Signals;
signals:
    void screenshotChanged();

    // PUBLIC Methods;
public:
    Q_INVOKABLE void takeScreenshot(const QString &screenName); // Full screen
    Q_INVOKABLE void takeScreenshot(const QString &screenName, float x, float y, qint64 width, qint64 height); // Custom area
    Q_INVOKABLE void saveScreenshot(const QString &path);

    // PRIVATE Methods;
private:
    void cacheTheme(const QString &themeKey);
    QString resolvePlaceholders(const QString &themeJson, const QString &placeholderJson);

    // PUBLIC Getters
public:
    QPixmap getScreenshot() const;

    // PRIVATE Setters
private:
    void setScreenshot(const QPixmap &newScreenshot);
};

#endif // SCREENSHOT_H
