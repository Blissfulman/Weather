# Приложение Weather
## Одна из домашних работ курса «iOS-разработчик с нуля за 20 недель» сайта [swiftbook.ru](https://www.online.swiftbook.ru).
**Язык**: Swift.

**Тема урока**: работа с сетью.

**Требования к домашней работе**: взять любое открытое API и разработать приложение с его использованием.

**Требования к доработке**: реализовать загрузку данных с помощью библиотеки Alamofire, реализовать ручной парсинг данных.

**Общее время выполнения работы**: 3 дня.

Пример работы приложения:

![Weather](https://github.com/Blissfulman/Weather/blob/main/Example.gif)

Первый экран отображает информацию о текущей погоде в текущем месте, а также прогноз погоды на ближайшие 7 дней. Дополнительно имеется возможность открыть страницу сайта Яндекс.Погоды для данного населённого пункта во встроенном браузере.

На втором экране отображается таблица с краткой информацией о текущей погоде в различных городах мира. Реализована возможность удаления городов из таблицы, а также добавления новых городов. При нажатии на ячейку пользователь переходит на страницу сайта Яндекс.Погоды для данного населённого пункта во встроенном браузере.

В обучающих целях дополнительно был реализован ручной парсинг данных.

Для работы приложения **необходимо добавить ключ для доступа к API Яндекс.Погоды**. Его можно получить, зарегистрировавшись на сайте для разработчиков: [API Яндекс.Погоды](https://yandex.ru/dev/weather/).

**Вставить ключ**: `NetworkManager -> private let apiKey`.

В проекте используется менеджер зависимостей **Cocoapods**.

Загрузка изображений, получаемых от API осуществляется с использованием библиотеки **SwiftSVG**.

Определение координат населённых пунктов осуществляется с использованием **CoreLocation**, работа с сетью реализована как нативными средствами, так и с использованием библиотеки **Alamofire**.
