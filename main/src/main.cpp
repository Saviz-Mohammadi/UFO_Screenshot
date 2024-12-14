#include "main.hpp"

#ifdef QT_DEBUG
    #include "logger.hpp"
#endif

int main(int argc, char *argv[])
{
    QGuiApplication application(argc, argv);
    QQmlApplicationEngine engine;

    registerTypes();
    setupThemeSystem();
    chooseFirstTheme();
    readCustomFonts(application);
    setGlobalFont(application);

    // WARNING (SAVIZ): This function does not work correctly under Wayland.
    QGuiApplication::setWindowIcon(QIcon("./resources/icons/Application icons/ufo.png"));

    engine.load("./resources/qml/main.qml");

    return application.exec();
}

void registerTypes()
{
    qmlRegisterSingletonType<AppTheme>("AppTheme", 1, 0, "AppTheme", &AppTheme::qmlInstance);
    qmlRegisterSingletonType<Screenshot>("Screenshot", 1, 0, "Screenshot", &Screenshot::qmlInstance);
}

void setupThemeSystem()
{
    AppTheme *appTheme = AppTheme::cppInstance();

    appTheme->addThemes("./resources/json/themes");
}

void chooseFirstTheme()
{
    AppTheme *appTheme = AppTheme::cppInstance();

    QString lastUsedThemeKey = appTheme->getCachedTheme();


    if(!lastUsedThemeKey.isEmpty())
    {
        appTheme->loadColorsFromTheme(lastUsedThemeKey);

        return;
    }

    appTheme->loadColorsFromTheme("ufo_light");
}

void readCustomFonts(const QGuiApplication &application)
{
    QStringList fontPaths;

    fontPaths << "./resources/fonts/Titillium_Web/TitilliumWeb-Black.ttf"
              << "./resources/fonts/Titillium_Web/TitilliumWeb-Bold.ttf"
              << "./resources/fonts/Titillium_Web/TitilliumWeb-BoldItalic.ttf"
              << "./resources/fonts/Titillium_Web/TitilliumWeb-ExtraLight.ttf"
              << "./resources/fonts/Titillium_Web/TitilliumWeb-ExtraLightItalic.ttf"
              << "./resources/fonts/Titillium_Web/TitilliumWeb-Italic.ttf"
              << "./resources/fonts/Titillium_Web/TitilliumWeb-Light.ttf"
              << "./resources/fonts/Titillium_Web/TitilliumWeb-LightItalic.ttf"
              << "./resources/fonts/Titillium_Web/TitilliumWeb-Regular.ttf"
              << "./resources/fonts/Titillium_Web/TitilliumWeb-SemiBold.ttf"
              << "./resources/fonts/Titillium_Web/TitilliumWeb-SemiBoldItalic.ttf";

    foreach (const QString &fontPath, fontPaths)
    {
        int fontId = QFontDatabase::addApplicationFont(fontPath);

        if (fontId == -1)
        {
#ifdef QT_DEBUG
            QString message("Failed to load font file: %1");

            message = message.arg(fontPath);

            logger::log(logger::LOG_LEVEL::DEBUG, "N/A", Q_FUNC_INFO, message);
#endif
        }
    }
}

void setGlobalFont(const QGuiApplication &application)
{
    // NOTE (SAVIZ): The name is automatically set by Qt and depends on the metadata of the file. Refer to "Google Fonts" to find out the correct name to use.
    QString fontFamilyName = "Titillium Web";


    if (QFontDatabase::families().contains(fontFamilyName))
    {
        QFont customFont(fontFamilyName, 10);

        QGuiApplication::setFont(customFont);
    }

    else
    {
#ifdef QT_DEBUG
        QString message("Font family %1 is not available.");

        message = message.arg(fontFamilyName);

        logger::log(logger::LOG_LEVEL::DEBUG, "N/A", Q_FUNC_INFO, message);
#endif
    }
}
