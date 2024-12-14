#include "screenshot.hpp"

#ifdef QT_DEBUG
    #include "logger.hpp"
#endif


Screenshot* Screenshot::m_Instance = Q_NULLPTR;

// Constructors, Initializers, Destructor
// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]

Screenshot::Screenshot(QObject *parent, const QString& name)
    : QObject{parent}
    , m_Screenshot(QPixmap{})
    , m_ScreenshotExists(false)
    , m_Delay(quint64(875))
{
    this->setObjectName(name);

    // TODO (SAVIZ): Probably good idea to refactor this and make it universally accessible.
    QDir dir("./cache/screenshots");

    if(!dir.exists())
    {
        dir.mkpath("./cache/screenshots");
    }

#ifdef QT_DEBUG
    QString message("Call to Constructor");

    logger::log(logger::LOG_LEVEL::DEBUG, this->objectName(), Q_FUNC_INFO, message);
#endif
}

Screenshot::~Screenshot()
{
#ifdef QT_DEBUG
    QString message("Call to Destructor");

    logger::log(logger::LOG_LEVEL::DEBUG, this->objectName(), Q_FUNC_INFO, message);
#endif
}

Screenshot *Screenshot::qmlInstance(QQmlEngine *engine, QJSEngine *scriptEngine)
{
    Q_UNUSED(engine);
    Q_UNUSED(scriptEngine);

    if (!m_Instance)
    {
        m_Instance = new Screenshot();
    }

    return(m_Instance);
}

Screenshot *Screenshot::cppInstance(QObject *parent)
{
    if(m_Instance)
    {
        return(qobject_cast<Screenshot *>(Screenshot::m_Instance));
    }

    auto instance = new Screenshot(parent);
    m_Instance = instance;
    return(instance);
}

// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]





// PUBLIC Methods
// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]

void Screenshot::initiateScreenshot(const QString &screenName)
{
    // NOTE (SAVIZ): Waiting makes sure that the window has enough time to hide.
    QTimer::singleShot(

        m_Delay,
        this,
        [this, screenName]() {
            this->takeScreenshot(screenName);
        }
    );
}

void Screenshot::initiateScreenshot(const QString &screenName, qreal x, qreal y, qint64 width, qint64 height)
{
    // NOTE (SAVIZ): Waiting makes sure that the window has enough time to hide.
    QTimer::singleShot(

        m_Delay,
        this,
        [this, screenName, x, y, width, height]() {
            this->takeScreenshot(screenName, x, y, width, height);
        }
    );
}

bool Screenshot::fileExists(const QString &path)
{
    QFileInfo fileInfo(path);

    if(fileInfo.exists())
    {
        return (true);
    }

    return (false);
}

void Screenshot::saveScreenshot(QUrl path)
{
    bool success = m_Screenshot.save(path.toLocalFile(), Q_NULLPTR);

    if(!success)
    {
        emit saveUnsuccessful();
    }

    emit saveSuccessful();
}

// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]





// PRIVATE Methods
// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]

// NOTE (SAVIZ): This method is for "FullScreen" mode.
void Screenshot::takeScreenshot(const QString &screenName)
{
    QScreen* selectedScreen = Q_NULLPTR;

    for (QScreen *screen : QGuiApplication::screens())
    {
        if (screen->name() == screenName)
        {
            selectedScreen = screen;
            break;
        }
    }

    // WARNING (SAVIZ): The "grabWindow()" method does not work correctly under Wayland.
    setScreenshot(selectedScreen->grabWindow(0));

    setScreenshotExists(true);
}

// NOTE (SAVIZ): This method is for "CustomArea" mode.
void Screenshot::takeScreenshot(const QString &screenName, qreal x, qreal y, qint64 width, qint64 height)
{
    QScreen* selectedScreen = Q_NULLPTR;

    for (QScreen *screen : QGuiApplication::screens())
    {
        if (screen->name() == screenName)
        {
            selectedScreen = screen;
            break;
        }
    }

    // WARNING (SAVIZ): The "grabWindow()" method does not work correctly under Wayland.
    setScreenshot(
        selectedScreen->grabWindow(
            0,
            x,
            y,
            width,
            height
        )
    );

    setScreenshotExists(true);
}

// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]





// PUBLIC Getters
// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]

QUrl Screenshot::getScreenshot() const
{
    QDir dir("./cache/screenshots");

    m_Screenshot.save("./cache/screenshots/temp.png", Q_NULLPTR);

    return (QUrl::fromLocalFile(dir.absolutePath() + "/temp.png"));
}

bool Screenshot::getScreenshotExists() const
{
    return (m_ScreenshotExists);
}

// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]





// PRIVATE Setters
// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]

void Screenshot::setScreenshot(QPixmap newScreenshot)
{
    m_Screenshot = newScreenshot.copy();

    m_Screenshot.save("./cache/screenshots/temp.png", Q_NULLPTR);

    emit screenshotChanged();
}

void Screenshot::setScreenshotExists(bool newScreenshotExists)
{
    m_ScreenshotExists = newScreenshotExists;

    emit screenshotExistsChanged();
}

// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]
