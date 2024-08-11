#ifndef MAIN_H
#define MAIN_H

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QFontDatabase>
#include <QIcon>
#include "app_theme.hpp"

void registerTypes();
void setupThemeSystem();
void chooseFirstTheme();
void readCustomFonts(const QGuiApplication &application);
void setGlobalFont(const QGuiApplication &application);

#endif  //MAIN_H
