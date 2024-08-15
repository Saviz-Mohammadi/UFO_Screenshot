#include "screenshot.hpp"

Screenshot* Screenshot::m_Instance = nullptr;

// Constructors, Initializers, Destructor
// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]

Screenshot::Screenshot(QObject *parent, const QString& name)
    : QObject{parent}
    , m_Screenshot(QPixmap{})
    , m_ScreenshotExists(false)
    , m_Delay(quint64(900))
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

             // For more information, search about an operating system's scale factor;
            // copy.setDevicePixelRatio(primaryScreen->devicePixelRatio());
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

// This method is for FullScreen.
void Screenshot::takeScreenshot(const QString &screenName)
{
    qDebug() << "Full screen method called";
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

    if(selectedScreen == nullptr)
    {
        qDebug() << "Screen is null";
    }

    if (!selectedScreen) {
        qDebug() << "Error: No screen found with name" << screenName;
    }


    qDebug() << "Screen geometry:" << selectedScreen->geometry();
    qDebug() << "Device pixel ratio:" << selectedScreen->devicePixelRatio();


    // Wait for 850 miliseconds before calling the method;
    // This makes sure that the window has enough time to hide;
    QTimer::singleShot(

        850,
        this,
        [this, selectedScreen]()
        {
            // Grab entire screen
            // I have since found out that grabWindow doesn’t work under Wayland. So I either have to find another way or resort to X11 again.
            QPixmap output = selectedScreen->grabWindow(0, selectedScreen->geometry().x(), selectedScreen->geometry().y(), selectedScreen->geometry().width(), selectedScreen->geometry().height());


            //     setScreenshot(

            // );

            if (output.isNull()) {
                qDebug() << "Pixmap is null.";
            }

            // m_Screenshot.setDevicePixelRatio(
            //     selectedScreen->devicePixelRatio()
            // );

            setScreenshotExists(true);
        }
    );
}

// This method is for SelectedArea.
void Screenshot::takeScreenshot(const QString &screenName, float x, float y, qint64 width, qint64 height)
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

    // Wait for 850 miliseconds before calling the method;
    // This makes sure that the window has enough time to hide;
    QTimer::singleShot(

        850,
        this,
        [this, selectedScreen, x, y, width, height]()
        {
            // Grab entire screen
            setScreenshot(
                selectedScreen->grabWindow(
                    0,
                    x,
                    y,
                    width,
                    height
                )
            );

            if (m_Screenshot.isNull()) {
                qDebug() << "Pixmap is null.";
            }

            // m_Screenshot.setDevicePixelRatio(
            //     selectedScreen->devicePixelRatio()
            // );

            setScreenshotExists(true);
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

void Screenshot::saveScreenshot(const QString &path)
{
    // The following checks are assumed to be already done in qml:
    //
    // Save button is enabled via screenShotExits (THis way we don't have to manulaly check if Qpixmap is not null)
    // Selecting file path.
    // Making sure file path is not empty.
    // Handle if file exists already.

    if (m_Screenshot.isNull()) {
        qDebug() << "Pixmap is null.";
    }

    bool success = m_Screenshot.save(
        path,
        "PNG"
    );

    if(success == false)
    {
        emit screenshotSaveUnsuccessful();
        qDebug() << "Save unsuccesful!";
    }

    emit screenshotSaveSuccessful();
}

// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]





// PRIVATE Methods
// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]


// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]





// PUBLIC Getters
// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]

QString Screenshot::getScreenshot() const
{
    QByteArray byteArray;
    QBuffer buffer(&byteArray);

    buffer.open(QIODevice::WriteOnly);
    int quality = 100; // (default) compressed data, slower // int quality = 100; // large uncompressed data, faster

    m_Screenshot.toImage().save(&buffer, "png", quality);
    QString base64 = QString::fromUtf8(byteArray.toBase64());

    buffer.close();

    return QString("data:image/png;base64,") + base64;
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

void Screenshot::setScreenshot(const QPixmap &newScreenshot)
{
    // QPixmaps cannot be compared in an easy way.

    m_Screenshot = newScreenshot.copy();
    emit screenshotChanged();
}

void Screenshot::setScreenshotExists(bool newScreenshotExists)
{
    m_ScreenshotExists = newScreenshotExists;
    emit screenshotExistsChanged();
}

// [[------------------------------------------------------------------------]]
// [[------------------------------------------------------------------------]]
