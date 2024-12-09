#ifndef SCREENSHOT_H
#define SCREENSHOT_H

#include <QObject>
#include <QtTypes>
#include <QFile>
#include <QFileInfo>
#include <QDir>
#include <QTimer>
#include <QScreen>
#include <QPixmap>
#include <QPainter>
#include <QGuiApplication>
#include <QQmlEngine>
#include <QBuffer>
#include <QUrl>

class Screenshot : public QObject
{
    Q_OBJECT
    Q_DISABLE_COPY_MOVE(Screenshot) // Needed for Singleton pattern.

    // Q_PROPERTY;

    // This might be surprising, I need to explain this:
    // After doing some massive research, it turns out the only way to fully sync a QPixmap with QML is by
    // subclassing a type called "QQuikcImageProvider" or something like that. This is way too complicated in my
    // opinnion. So, instead what we do is send the image data through a String stream. For our purposes this should be enough for now.
    Q_PROPERTY(QUrl screenshot READ getScreenshot NOTIFY screenshotChanged)
    Q_PROPERTY(bool screenshotExists READ getScreenshotExists NOTIFY screenshotExistsChanged)

    // Constructors, Initializers, Destructor
public:
    explicit Screenshot(QObject *parent = nullptr, const QString& name = "No name");
    ~Screenshot();

    static Screenshot *qmlInstance(QQmlEngine *engine, QJSEngine *scriptEngine);
    static Screenshot *cppInstance(QObject *parent = nullptr);

    // Fields;
private:
    static Screenshot *m_Instance;
    QPixmap m_Screenshot;
    bool m_ScreenshotExists;
    quint64 m_Delay;

    // Signals;
signals:
    void screenshotChanged();
    void screenshotExistsChanged();
    void saveSuccessful();
    void saveUnsuccessful();

    // PUBLIC Methods;
public:
    Q_INVOKABLE void initiateScreenshot(const QString &screenName);
    Q_INVOKABLE void initiateScreenshot(const QString &screenName, qreal x, qreal y, qint64 width, qint64 height);
    Q_INVOKABLE bool fileExists(const QString &path);
    Q_INVOKABLE void saveScreenshot(QUrl path);

    // PRIVATE Methods;
private:
    void takeScreenshot(const QString &screenName);
    void takeScreenshot(const QString &screenName, qreal x, qreal y, qint64 width, qint64 height);

    // PUBLIC Getters
public:
    QUrl getScreenshot() const;
    bool getScreenshotExists() const;

    // PRIVATE Setters
private:
    void setScreenshot(QPixmap newScreenshot);
    void setScreenshotExists(bool newScreenshotExists);
};

#endif // SCREENSHOT_H
