#ifndef SCREENSHOT_H
#define SCREENSHOT_H

#include <QObject>
#include <QtTypes>
#include <QFile>
#include <QFileInfo>
#include <QTimer>
#include <QScreen>
#include <QPixmap>
#include <QGuiApplication>
#include <QQmlEngine>
#include <QBuffer>

class Screenshot : public QObject
{
    Q_OBJECT
    Q_DISABLE_COPY_MOVE(Screenshot) // Needed for Singleton pattern.

    // Q_PROPERTY;
    Q_PROPERTY(QString screenshot READ getScreenshot NOTIFY screenshotChanged)
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
    QPixmap m_Screenshot; // Use an "Image" element with this in qml
    bool m_ScreenshotExists;
    quint64 m_Delay;

    // Signals;
signals:
    void screenshotChanged();
    void screenshotExistsChanged();
    void screenshotSaveSuccessful();
    void screenshotSaveUnsuccessful();

    // PUBLIC Methods;
public:
    Q_INVOKABLE void takeScreenshot(const QString &screenName); // Full screen
    Q_INVOKABLE void takeScreenshot(const QString &screenName, float x, float y, qint64 width, qint64 height); // Custom area
    Q_INVOKABLE bool fileExists(const QString &path);
    Q_INVOKABLE void saveScreenshot(const QString &path);

    // PRIVATE Methods;
private:

    // PUBLIC Getters
public:
    QString getScreenshot() const;
    bool getScreenshotExists() const;

    // PRIVATE Setters
private:
    void setScreenshot(const QPixmap &newScreenshot);
    void setScreenshotExists(bool newScreenshotExists);
};

#endif // SCREENSHOT_H
