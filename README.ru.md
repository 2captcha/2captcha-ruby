<a href="https://github.com/2captcha/2captcha-python"><img src="https://github.com/user-attachments/assets/37e1d860-033b-4cf3-a158-468fc6b4debc" width="82" height="30"></a>
<a href="https://github.com/2captcha/2captcha-javascript"><img src="https://github.com/user-attachments/assets/4d3b4541-34b2-4ed2-a687-d694ce67e5a6" width="36" height="30"></a>
<a href="https://github.com/2captcha/2captcha-go"><img src="https://github.com/user-attachments/assets/ab22182e-6cb2-41fa-91f4-d5e89c6d7c6f" width="63" height="30"></a>
<a href="https://github.com/2captcha/2captcha-ruby"><img src="https://github.com/user-attachments/assets/1c3b6dc2-9acd-44fe-927d-31de3427639f" width="75" height="30"></a>
<a href="https://github.com/2captcha/2captcha-cpp"><img src="https://github.com/user-attachments/assets/36de8512-acfd-44fb-bb1f-b7c793a3f926" width="45" height="30"></a>
<a href="https://github.com/2captcha/2captcha-php"><img src="https://github.com/user-attachments/assets/e8797843-3f61-4fa9-a155-ab0b21fb3858" width="52" height="30"></a>
<a href="https://github.com/2captcha/2captcha-java"><img src="https://github.com/user-attachments/assets/a3d923f6-4fec-4c07-ac50-e20da6370911" width="50" height="30"></a>
<a href="https://github.com/2captcha/2captcha-csharp"><img src="https://github.com/user-attachments/assets/f4d449de-780b-49ed-bb0a-b70c82ec4b32" width="38" height="30"></a>

# Ruby 2Captcha API Client (captcha solver)

Это самый простой способ быстро интегрировать [2Captcha] в ваш код и автоматизировать решение любого типа капчи.
Примеры API-запросов для различных типов капч доступны на странице [Ruby captcha solver](https://2captcha.com/lang/ruby).

- [Ruby 2Captcha API Client (captcha solver)](#ruby-2captcha-api-client-captcha-solver)
  - [Установка](#установка)
  - [Настройка](#настройка)
      - [Опции экземпляра клиента](#опции-экземпляра-клиента)
  - [Решение капчи](#решение-капчи)
    - [Обычная капча](#обычная-капча)
    - [Текстовая капча](#текстовая-капча)
    - [reCAPTCHA v2](#recaptcha-v2)
    - [reCAPTCHA v3](#recaptcha-v3)
    - [FunCaptcha](#funcaptcha)
    - [GeeTest](#geetest)
    - [GeeTest V4](#geetest-v4)
    - [hCaptcha](#hcaptcha)
    - [KeyCaptcha](#keycaptcha)
    - [Capy](#capy)
    - [Grid](#grid)
    - [Canvas](#canvas)
    - [ClickCaptcha](#clickcaptcha)
    - [Rotate](#rotate)
    - [Amazon WAF](#amazon-waf)
    - [Cloudflare Turnstile](#cloudflare-turnstile)
    - [Lemin Cropped Captcha](#lemin-cropped-captcha)
    - [Распознавание аудио](#распознавание-аудио)
    - [CyberSiARA](#cybersiara)
    - [DataDome](#datadome)
    - [MTCaptcha](#mtcaptcha)
    - [Friendly captcha](#friendly-captcha)
    - [Cutcaptcha](#cutcaptcha)
    - [Tencent](#tencent)
    - [atbCAPTCHA](#atbcaptcha)
  - [Другие методы](#другие-методы)
    - [send / get_result](#send--get_result)
    - [Баланс](#баланс)
    - [Отчет](#отчет)
  - [Прокси](#прокси)
  - [Обработка ошибок](#обработка-ошибок)
  - [Примеры](#примеры)
- [Свяжитесь с нами](#свяжитесь-с-нами)
- [Присоединяйтесь к команде 👪](#join-the-team)
- [Лицензия](#лицензия)
  - [Графика и товарные знаки](#графика-и-товарные-знаки)

## Установка
Автоматическая установка гема с помощью Bundler. Добавьте следующую строку в ваш Gemfile:

```ruby
gem 'ruby-2captcha'
```
Затем выполните следующую команду в терминале:

```ruby
bundle install
```

Или установите его самостоятельно, выполнив следующую команду в терминале:

```ruby
gem install ruby-2captcha
```

Мы также приглашаем вас ознакомиться с нашим репозиторием на [GitHub](https://github.com/2captcha/), где вы можете найти библиотеки и модули для простой интеграции с нашим API.

## Настройка

Описание всех необходимых параметров для настройки установленного гема.

Экземпляр класса `Api2Captcha` можно создать следующим образом:

```ruby
require 'api_2captcha'

client =  Api2Captcha.new("YOUR_API_KEY")
```
### Опции экземпляра клиента
У вас также есть возможность настроить некоторые параметры экземпляра `Api2Captcha`:

```ruby
client.soft_id(123)
client.domain("https://rucaptcha.com/")
client.callback("https://your.site/result-receiver")
client.default_timeout(120)
client.polling_interval(10)
```

>  [!IMPORTANT]
> После определения обратного вызова для экземпляра, все методы возвращают только идентификатор капчи и НЕ запрашивают результат у API. Результат будет отправлен на URL обратного вызова.

Чтобы получить ответ вручную, используйте метод [get_result](#send--get_result).

## Решение капчи
При отправке любой капчи, основанной на изображении, вы можете предоставить дополнительные параметры, чтобы помочь работникам 2Captcha правильно её решить.

### Параметры капчи

| Параметр          | Значение по умолчанию | Описание                                                                                                   |
|-------------------|---------------|--------------------------------------------------------------------------------------------------------------------|
| numeric           | 0             | Определяет, содержит ли капча числа или другие символы [подробнее см. в документации по API](https://2captcha.com/2captcha-api#solving_normal_captcha) |
| min_len           | 0             | Минимальная длина ответа length                                                                                    |
| max_len           | 0             | Максимальная длина ответа length                                                                                   |
| phrase            | 0             | Определяет, содержит ли ответ несколько слов или нет                                                               |
| case_sensitive    | 0             | Определяет, учитывается ли регистр в ответе                                                                        |
| calc              | 0             | Определяет, требуется ли вычисление в решении капчи                                                                |
| lang              | -             | Определяет язык капчи, см. [список поддерживаемых языков](https://2captcha.com/2captcha-api#language)                                                          |
| hint_image        | -             | Изображение с подсказкой, показываемое работникам с капчей, переведенное из параметра API instructionsimg          |
| hint_text         | -             | Подсказка или текст задания, показываемые работникам с капчей                                                      |

Ниже вы найдете основные примеры для каждого типа капчи. Ознакомьтесь с кодом ниже.

### Обычная капча

<sup>[Описание метода API.](https://2captcha.com/2captcha-api#solving_normal_captcha)</sup>

Для обхода обычной капчи (искаженный текст на картинке) используйте следующий метод. Этот метод также может использоваться для распознавания любого текста на картинке.

```ruby
result = client.normal({ image: 'path/to/captcha.jpg'})
# OR
result = client.normal({
  image: 'https://site-with-captcha.com/path/to/captcha.jpg'
})
```

### Текстовая капча

<sup>[Описание метода API.](https://2captcha.com/2captcha-api#solving_text_captcha)</sup>

Этот метод может использоваться для обхода капчи, которая требует ответить на вопрос, представленный в явном виде.

```ruby
result = client.text({
  textcaptcha:'Если завтра суббота, то какой сегодня день?',
  lang: "ru"
})
```

### reCAPTCHA v2

<sup>[Описание метода API.](https://2captcha.com/2captcha-api#solving_recaptchav2_new)</sup>

Используйте этот метод для решения reCAPTCHA v2 и получения токена для обхода защиты.

```ruby
result = client.recaptcha_v2({
  googlekey: '6Le-wvkSVVABCPBMRTvw0Q4Muexq1bi0DJwx_mJ-',
  pageurl: 'https://mysite.com/page/with/recaptcha_v2',
  invisible: 1
})
```

### reCAPTCHA v3

<sup>[Описание метода API.](https://2captcha.com/2captcha-api#solving_recaptchav3)</sup>

Этот метод предоставляет решение для reCAPTCHA v3 и возвращает токен.

```ruby
result = client.recaptcha_v3({
  googlekey: '6Le-wvkSVVABCPBMRTvw0Q4Muexq1bi0DJwx_mJ-',
  pageurl: 'https://mysite.com/page/with/recaptcha_v3',
  version: 'v3',
  score: 0.3,
  action: 'verify'
})
```

### FunCaptcha

<sup>[Описание метода API.](https://2captcha.com/2captcha-api#solving_funcaptcha_new)</sup>

Метод решения FunCaptcha (Arkoselabs). Он возвращает токен.

```ruby
result = client.funcaptcha({
   publickey: "69A21A01-CC7B-B9C6-0F9A-E7FA06677FFC",
   pageurl: "https://mysite.com/page/with/funcaptcha",
   surl: "https://client-api.arkoselabs.com"})
```

### GeeTest

<sup>[Описание метода API.](https://2captcha.com/2captcha-api#solving_geetest)</sup>

Метод для решения головоломки GeeTest captcha. Он возвращает набор токенов в формате JSON.

```ruby
result = client.geetest({
  gt: 'f1ab2cdefa3456789012345b6c78d90e',
  api_server: 'api-na.geetest.com',
  challenge: '12345678abc90123d45678ef90123a456b',
  pageurl: 'https://www.site.com/page/'
})
```

### GeeTest v4

<sup>[Описание метода API.](https://2captcha.com/2captcha-api#geetest-v4)</sup>

Используйте этот метод для решения GeeTest v4. Он возвращает ответ в формате JSON.

```ruby
result = client.geetest_v4({
  captcha_id: 'e392e1d7fd421dc63325744d5a2b9c73',
  pageurl: 'https://www.site.com/page/'
})
```

### hCaptcha

<sup>[Описание метода API.](https://2captcha.com/2captcha-api#solving_hcaptcha)</sup>

Метод решения hCaptcha. Он возвращает токен для обхода капчи.

```ruby
result = client.hcaptcha({
  sitekey: '10000000-ffff-ffff-ffff-000000000001',
  pageurl: 'https://www.site.com/page/'
})
```

### KeyCaptcha

<sup>[Описание метода API.](https://2captcha.com/2captcha-api#solving_keycaptcha)</sup>

Метод на основе токенов для решения KeyCaptcha.

```ruby
result = client.keycaptcha({
  s_s_c_user_id: 10,
  s_s_c_session_id: '493e52c37c10c2bcdf4a00cbc9ccd1e8',
  s_s_c_web_server_sign: '9006dc725760858e4c0715b835472f22-pz-',
  s_s_c_web_server_sign2: '2ca3abe86d90c6142d5571db98af6714',
  pageurl: 'https://www.keycaptcha.ru/demo-magnetic/'
})
```

### Capy

<sup>[Описание метода API.](https://2captcha.com/2captcha-api#solving_capy)</sup>

Метод основан на использовании токенов для обхода паззла Capy.

```ruby
result = client.capy({
  sitekey: 'PUZZLE_Abc1dEFghIJKLM2no34P56q7rStu8v',
  pageurl: 'http://mysite.com/',
  api_server: 'https://jp.api.capy.me/'
})
```

### Grid

<sup>[Описание метода API.](https://2captcha.com/2captcha-api#grid)</sup>

Метод сетки изначально называется методом Old ReCaptcha V2. Этот метод может быть использован для обхода любого типа капчи, где вы можете применить сетку к изображению и необходимо кликнуть по определенным ячейкам сетки. Он возвращает количество выбранных ячеек.

```ruby
result = client.grid({
  image: 'path/to/captcha.jpg',
  rows: 3,
  cols: 3,
  previous_id: 0,
  lang: 'en',
  hint_image: 'path/to/hint.jpg',
  hint_text: 'Select all images with an Orange'
})
```

### Canvas

<sup>[Описание метода API.](https://2captcha.com/2captcha-api#canvas)</sup>

Метод Canvas может быть использован, когда вам необходимо нарисовать линию вокруг объекта на изображении. Он возвращает набор координат точек для рисования многоугольника.

```ruby
result = client.canvas({
  image: 'path/to/captcha.jpg',
  previous_id: 0,
  lang: 'en',
  hint_image: 'path/to/hint.jpg',
  hint_text: 'Draw around apple'
})
```

### ClickCaptcha

<sup>[Описание метода API.](https://2captcha.com/2captcha-api#coordinates)</sup>

Метод ClickCaptcha возвращает координаты точек на изображении капчи. Может быть использован, если вам необходимо кликнуть по определенным точкам на изображении.

```ruby
result = client.coordinates({
  image: 'path/to/captcha.jpg',
  lang: 'en',
  hint_image: 'path/to/hint.jpg',
  hint_text: 'Connect the dots'
})
```

### Rotate

<sup>[Описание метода API.](https://2captcha.com/2captcha-api#solving_rotatecaptcha)</sup>

Этот метод может быть использован для решения капчи, которая просит повернуть объект. В основном используется для обхода FunCaptcha. Он возвращает угол поворота.

```ruby
result = client.rotate({
  image: 'path/to/captcha.jpg',
  angle: 40,
  lang: 'en',
  hint_image: 'path/to/hint.jpg',
  hint_text: 'Put the images in the correct way'
})
```


### Lemin Cropped Captcha

<sup>[Описание метода API.](https://2captcha.com/2captcha-api#lemin)</sup>

Используйте этот метод для решения задания Lemin. Он возвращает JSON-ответ с указанными значениями: ответ (answer) и идентификатор задания (challenge_id).

```ruby
result = client.lemin({
  captcha_id: 'CROPPED_1abcd2f_a1234b567c890d12ef3a456bc78d901d',
  div_id: 'lemin-cropped-captcha',
  pageurl: 'https://www.site.com/page/',
  api_server: "https://api.leminnow.com/"
})
```


### Cloudflare Turnstile

<sup>[Описание метода API.](https://2captcha.com/2captcha-api#turnstile)</sup>

Используйте этот метод для решения задачи Cloudflare Turnstile. Он возвращает JSON с токеном.

```ruby
result = client.turnstile({
  sitekey: '0x1AAAAAAAAkg0s2VIOD34y5',
  pageurl: 'http://mysite.com/'
})
```

### Amazon WAF

<sup>[Описание метода API.](https://2captcha.com/2captcha-api#amazon-waf)</sup>

Используйте этот метод для решения Captcha Amazon WAF, также известного как AWS WAF Captcha, который является частью интеллектуальной защиты от угроз для Amazon AWS. Он возвращает JSON с токеном.

```ruby
result = client.amazon_waf({
  sitekey: '0x1AAAAAAAAkg0s2VIOD34y5',
  iv: 'CgAHbCe2GgAAAAAj',
  context: '9BUgmlm48F92WUoqv97a49ZuEJJ50TCk9MVr3C7WMtQ0X6flVbufM4n8mjFLmbLVAPgaQ1Jydeaja94iAS49ljb+sUNLoukWedAQZKrlY4RdbOOzvcFqmD/ZepQFS9N5w15Exr4VwnVq+HIxTsDJwRviElWCdzKDebN/mk8/eX2n7qJi5G3Riq0tdQw9+C4diFZU5E97RSeahejOAAJTDqduqW6uLw9NsjJBkDRBlRjxjn5CaMMo5pYOxYbGrM8Un1JH5DMOLeXbq1xWbC17YSEoM1cRFfTgOoc+VpCe36Ai9Kc=',
  pageurl: 'https://non-existent-example.execute-api.us-east-1.amazonaws.com/latest',
  challenge_script: "https://41bcdd4fb3cb.610cd090.us-east-1.token.awswaf.com/41bcdd4fb3cb/0d21de737ccb/cd77baa6c832/challenge.js",
  captcha_script: "https://41bcdd4fb3cb.610cd090.us-east-1.captcha.awswaf.com/41bcdd4fb3cb/0d21de737ccb/cd77baa6c832/captcha.js"
})
```

### Распознавание аудио

<sup>[Описание метода API.](https://2captcha.com/2captcha-api#audio)</sup>

Этот метод можно использовать как для решения аудио капчи, так и для распознавания любой аудиозаписи. 

Поддерживаемые языки: "en", "ru", "de", "el", "pt", "fr".

```ruby
result = client.audio({
  audio: 'path/to/audio.mp3',
  lang: "en"
})
```

### CyberSiARA

<sup>[Описание метода API.](https://2captcha.com/2captcha-api#cybersiara)</sup>

Метод решения CyberSiARA. Он возвращает токен для обхода капчи.

```ruby
result = client.cyber_siara({
  pageurl: "https://test.com",
  master_url_id: "12333-3123123"
})
```

### DataDome

<sup>[Описание метода API.](https://2captcha.com/2captcha-api#datadome)</sup>

Метод решения DataDome вернет `cookies` для обхода капчи.

> [!IMPORTANT]
> Чтобы решить капчу DataDome вы должны обязательно использовать прокси. Рекомендуется использовать [резидентные прокси].

```ruby
result = client.data_dome({
  pageurl: "https://test.com",
  captcha_url: "https://test.com/captcha/",
  proxytype: "http",
  proxy: "proxyuser:strongPassword@123.123.123.123:3128"
})
```


### MTCaptcha

<sup>[Описание метода API.](https://2captcha.com/2captcha-api#mtcaptcha)</sup>

Метод решения MTCaptcha. Он возвращает токен для обхода капчи.

```ruby
result = client.mt_captcha({
  pageurl: "https://service.mtcaptcha.com/mtcv1/demo/index.html",
  sitekey: "MTPublic-DemoKey9M"
})
```


### Friendly captcha

<sup>[Описание метода API.](https://2captcha.com/2captcha-api#friendly-captcha)</sup>

Метод решения Friendly captcha. Он возвращает токен для обхода капчи.

> [!IMPORTANT]
> Чтобы успешно использовать полученный токен, виджет капчи не должен быть загружен на странице. Для этого необходимо прервать запрос к `/friendlycaptcha/...module.min.js` на странице. Если виджет капчи уже загружен на странице, существует высокая вероятность, что полученный токен не будет работать.

```ruby
result = client.friendly({
  pageurl: "https://example.com",
  sitekey: "2FZFEVS1FZCGQ9"
})
```

### Cutcaptcha

<sup>[Описание метода API.](https://2captcha.com/2captcha-api#cutcaptcha)</sup>

Метод решения Cutcaptcha. Он возвращает токен для обхода капчи.

```ruby
result = client.cutcaptcha({
  misery_key: "a1488b66da00bf332a1488993a5443c79047e752",
  api_key: "SAb83IIB",
  pageurl: "https://example.cc/foo/bar.html"
})
```

### Tencent

<sup>[Описание метода API.](https://2captcha.com/2captcha-api#tencent)</sup>

Основанный на токенах метод автоматизированного решения капчи Tencent.
```ruby
result = client.tencent({
  app_id: "197326679",
  pageurl: "https://mysite.com/page/with/tencent"
})
```

### atbCAPTCHA

<sup>[Описание метода API.](https://2captcha.com/2captcha-api#atb-captcha)</sup>

Основанный на токенах метод автоматизированного решения капчи atbCAPTCHA.
```ruby
result = client.atb_captcha({
  app_id: "197326679",
  api_server: "api.atb_captcha.com",
  pageurl: "https://mysite.com/page/with/atb_captcha"
})
```


## Другие методы

### send / get_result
Эти методы могут быть использованы для ручного отправления капчи и получения результата.

```ruby
# пример для обычной капчи
captcha_id = client.send('path/to/captcha.jpg')

# или для любой другой капчи
captcha_id = client.send({
  method:"lemin",
  captcha_id: "CROPPED_3dfdd5c_d1872b526b794d83ba3b365eb15a200b",
  api_server: "api.leminnow.com",
  div_id: "lemin-cropped-captcha",
  pageurl: "https://www.site.com/page/"
})

time.sleep(20)

# Получить готовый результат
result = client.get_result(captcha_id)
```
### Баланс

<sup>[Описание метода API.](https://2captcha.com/2captcha-api#additional-methods)</sup>

Используйте этот метод, чтобы посмотреть баланс в вашем аккаунте.

```ruby
balance = client.get_balance
```

### Отчет

<sup>[Описание метода API.](https://2captcha.com/2captcha-api#complain)</sup>

Используйте этот метод для отправки отчета о правильном или неправильном ответе на капчу.

```ruby
client.report(captcha_id, True) # капча решена правильно
client.report(captcha_id, False) # капча решена неправильно
```

## Прокси

Вы можете передать свой прокси-сервер в качестве дополнительного аргумента для методов: recaptcha, funcaptcha, geetest, geetest v4, hcaptcha, keycaptcha, capy puzzle, lemin, turnstile, amazon waf, Cutcaptcha, Friendly captcha, MTCaptcha, DataDome, CyberSiARA и других. Передынный Прокси-сервер будет перенаправлен в API и будет использован для загрузки капчи.

У нас есть свои собственные прокси-серверы, которые мы можем вам предложить. [Купить резидентские прокси] чтобы избежать ограничений и блокировок. [Быстрый старт].

Пример решения reCAPTCHA V2 с использованием прокси-сервера:

```ruby
result = client.recaptcha_v2({
  googlekey: '6Le-wvkSVVABCPBMRTvw0Q4Muexq1bi0DJwx_mJ-',
  pageurl: 'https://mysite.com/page/with/recaptcha_v2',
  invisible: 1,
  proxytype: "https",
  proxy: "proxyuser:strongPassword@123.123.123.123:3128"
})
```

## Обработка ошибок
В случае ошибки при решении капчи генерируется исключение. Важно правильно обрабатывать такие случаи. Мы рекомендуем использовать конструкцию `begin rescue` для обработки.

```ruby
  begin
  result = client.text('Если завтра суббота, то какой сегодня день?')
  rescue Api2Captcha::ValidationException => e
    # переданы недопустимые параметры
    puts(e)
  rescue Api2Captcha::NetworkException => e
    # возникла сетевая ошибка
    puts(e)
  rescue Api2Captcha::ApiException => e
    # ошибка ответа от API
    puts(e)
  rescue Api2Captcha::TimeoutException => e
    # капча до сих пор не решена
    puts(e)
  end
```

## Примеры

Примеры решения поддерживаемых типов капчи находятся в директории [examples].

## Свяжитесь с нами

<a href="mailto:support@2captcha.com"><img src="https://github.com/user-attachments/assets/539df209-7c85-4fa5-84b4-fc22ab93fac7" width="80" height="30"></a>
<a href="https://2captcha.com/support/tickets/new"><img src="https://github.com/user-attachments/assets/be044db5-2e67-46c6-8c81-04b78bd99650" width="81" height="30"></a>

<h2 id='join-the-team'>Присоединяйтесь к команде 👪</h2>

Есть много способов внести свой вклад, и разработка - лишь один из них! Найдите свою следующую работу. Открытые вакансии: AI experts, scrapers, developers, technical support, и многое другое! 😍

<a href="mailto:job@2captcha.com"><img src="https://github.com/user-attachments/assets/36d23ef5-7866-4841-8e17-261cc8a4e033" width="80" height="30"></a>

## Лицензия

Код в этом репозитории лицензируется по лицензии MIT. Более подробную информацию см. в файле [LICENSE](./LICENSE).

### Графика и товарные знаки

Графика и товарные знаки, включенные в этот репозиторий, не подпадают под действие лицензии MIT. За разрешениями на использование этих материалов обращайтесь в <a href="mailto:support@2captcha.com">службу поддержки</a>.

<!-- Shared links -->
[2Captcha]: https://2captcha.com/
[Купить резидентские прокси]: https://2captcha.com/proxy/residential-proxies
[Быстрый старт]: https://2captcha.com/proxy?openAddTrafficModal=true
[резидентные прокси]: https://2captcha.com/proxy/residential-proxies
[examples]: ./examples/