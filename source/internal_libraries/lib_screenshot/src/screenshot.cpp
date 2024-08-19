#include "screenshot.hpp"

Screenshot* Screenshot::m_Instance = nullptr;

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


// Debugging
#ifdef QT_DEBUG
    qDebug() << "\n**************************************************\n"
             << "* Object Name :" << this->objectName()  << "\n"
             << "* Function    :" << __FUNCTION__        << "\n"
             << "* Message     : Call to Constructor"
             << "\n**************************************************\n\n";
#endif
}

Screenshot::~Screenshot()
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
    // Waiting makes sure that the window has enough time to hide;
    QTimer::singleShot(

        m_Delay,
        this,
        [this, screenName]() {
            this->takeScreenshot(screenName);
        }
    );
}

void Screenshot::initiateScreenshot(
    const QString &screenName, qreal x, qreal y, qint64 width, qint64 height)
{
    // Waiting makes sure that the window has enough time to hide;
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
    //qDebug() << "The path was: " << path.toLocalFile();
    bool success = m_Screenshot.save(path.toLocalFile(), nullptr);

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

// This method is for "FullScreen".
void Screenshot::takeScreenshot(const QString &screenName)
{
    QScreen* selectedScreen = nullptr;

    // Find the screen with the specified name;
    for (QScreen *screen : QGuiApplication::screens())
    {
        if (screen->name() == screenName)
        {
            selectedScreen = screen;
            break;
        }
    }

    //qDebug() << screenName;
    //qDebug() << selectedScreen->name();


    // The "grabWindow()" function doesn’t work under Wayland.
    //m_Screenshot = ;

    //output.save("./testing.png", nullptr);

    setScreenshot(
        selectedScreen->grabWindow(0)
    );

    //            m_Screenshot.setDevicePixelRatio(
    //                selectedScreen->devicePixelRatio()
    //            );

    if(m_Screenshot.isNull())
    {
        qDebug() << "is null";
        return;
    }

    //m_Screenshot.copy(output);
    emit screenshotChanged();

    setScreenshotExists(true);
}

// This method is for "CustomArea".
void Screenshot::takeScreenshot(const QString &screenName, qreal x, qreal y, qint64 width, qint64 height)
{
    QScreen* selectedScreen = nullptr;

    // Find the screen with the specified name;
    for (QScreen *screen : QGuiApplication::screens())
    {
        if (screen->name() == screenName)
        {
            selectedScreen = screen;
            break;
        }
    }


    // The "grabWindow()" function doesn’t work under Wayland.
    setScreenshot(
        selectedScreen->grabWindow(
            0,
            x,
            y,
            width,
            height
            )
        );

    //            m_Screenshot.setDevicePixelRatio(
    //                selectedScreen->devicePixelRatio()
    //            );

    setScreenshotExists(true);
}

// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]





// PUBLIC Getters
// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]

// I honestly think it may be better to just save to cache and link to file for this one
QUrl Screenshot::getScreenshot() const
{

    // Probably good idea to refactor this and make it universally accessible.
QDir dir("./cache/screenshots");

m_Screenshot.save("./cache/screenshots/temp.png", nullptr);

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
    // It is not easy to compare a QPixmaps.
    // So, for now I just change it no matter what.

    m_Screenshot = newScreenshot.copy(); // Performing deep copy.

    // TODO turn this into pivate slot instead and connect to signal to trigger it
    m_Screenshot.save("./cache/screenshots/temp.png", nullptr);

    // Make a path to cache folder and save file.
    //m_Screenshot
    emit screenshotChanged();
}

void Screenshot::setScreenshotExists(bool newScreenshotExists)
{
    m_ScreenshotExists = newScreenshotExists;
    emit screenshotExistsChanged();
}

// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]
