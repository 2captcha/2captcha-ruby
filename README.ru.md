# Ruby 2Captcha API Client

Это самый простой способ быстро интегрировать 2Captcha в ваш код и автоматизировать решение любого типа капчи.

Ruby-клиент для API 2Captcha.

- [Установка](#installation)
- [Настройка](#configuration)
    - [Опции экземпляра клиента](#client-instance-options)
- [Решение капчи](#solve-captcha)
  - [Обычная капча](#normal-captcha)
  - [Текстовая капча](#text-captcha)
  - [ReCaptcha v2](#recaptcha-v2)
  - [ReCaptcha v3](#recaptcha-v3)
  - [GeeTest](#geetest)
  - [hCaptcha](#hcaptcha)
  - [KeyCaptcha](#keycaptcha)
  - [Capy](#capy)
  - [Grid](#grid)
  - [Canvas](#canvas)
  - [ClickCaptcha](#clickcaptcha)
  - [Rotate](#rotate)
  - [AmazonWAF](#amazon-waf)
  - [CloudflareTurnstile](#cloudflare-turnstile)
  - [Lemin Cropped Captcha](#lemin-cropped-captcha)
  - [GeeTest V4](#geetest-v4)
  - [Аудио](#audio)
- [Другие методы](#other-methods)
  - [send / get_result](#send--getresult)
  - [balance](#balance)
  - [report](#report)
  - [Обработка ошибок](#error-handling)

## Установка
Убедитесь, что у вас установлена версия Ruby 3.0.0 или выше. Если ваш проект использует другую версию Ruby, обновите свою среду Ruby до версии 3.0.0 или измените версию Ruby в вашем проекте.

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

Экземпляр класса Api2Captcha можно создать следующим образом:

```ruby
require 'api_2captcha'

client =  Api2Captcha.new("YOUR_API_KEY")
```

У вас также есть возможность настроить некоторые параметры экземпляра Api2Captcha:

```ruby
client.soft_id(123)
client.domain("https://rucaptcha.com/")
client.callback("https://your.site/result-receiver")
client.default_timeout(120)
client.polling_interval(10)
```

**ВАЖНО**: после определения обратного вызова для экземпляра , все методы возвращают только идентификатор капчи и НЕ запрашивают результат у API. Результат будет отправлен на URL обратного вызова. Чтобы получить ответ вручную, используйте метод get_result.

## Решение капчи
При отправке любой капчи, основанной на изображении, вы можете предоставить дополнительные параметры, чтобы помочь работникам 2Captcha правильно ее решить.

### Параметры капчи

| Параметр            | Значение по умолчанию | Описание                                                                                                                   |
|-------------------|---------------|-------------------------------------------------------------------------------------------------------------------------------|
| numeric           | 0             | Определяет, содержит ли капча числа или другие символы [подробнее см. в документации по API](https://2captcha.com/2captcha-api#normal_post)                              |
| min_len           | 0             |  Минимальная длина ответа length                                                                                                         |
| max_len           | 0             | Максимальная длина ответа length                                                                                                         |
| phrase            | 0             | Определяет, содержит ли ответ несколько слов или нет                                                                          |
| case_sensitive    | 0             | Определяет, учитывается ли регистр в ответе                                                                                         |
| calc              | 0             | Определяет, требуется ли вычисление в решении капчи                                                                                           |
| lang              | -             | Определяет язык капчи, см. [список поддерживаемых языков](https://2captcha.com/2captcha-api#language)                                                          |
| hint_image        | -             | Изображение с подсказкой, показываемое работникам с капчей, переведенное из параметра API instructionsimg                          |
| hint_text         | -             | Подсказка или текст задания, показываемые работникам с капчей                                                                            |

Ниже вы найдете основные примеры для каждого типа капчи. Ознакомьтесь с кодом ниже.

### Обычная капча
Для обхода обычной капчи (искаженный текст на картинке) используйте следующий метод. Этот метод также может использоваться для распознавания любого текста на картинке.
```ruby
result = client.normal({ image: 'path/to/captcha.jpg'})
# OR
result = client.normal({
  image: 'https://site-with-captcha.com/path/to/captcha.jpg'
})
```

### Текстовая капча
Этот метод может использоваться для обхода капчи, которая требует ответить на вопрос, представленный в явном виде.
```ruby
result = client.text({
  textcaptcha:'Если завтра суббота, то какой сегодня день?',
  lang: "ru"
})
```

### ReCaptcha v2
Используйте этот метод для решения ReCaptcha V2 и получения токена для обхода защиты.
```ruby
result = client.recaptcha_v2({
  googlekey: '6Le-wvkSVVABCPBMRTvw0Q4Muexq1bi0DJwx_mJ-',
  pageurl: 'https://mysite.com/page/with/recaptcha_v2',
  invisible: 1
})
```

### ReCaptcha v3
Этот метод предоставляет решение для ReCaptcha V3 и возвращает токен.
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
Метод решения FunCaptcha (Arkoselabs). Он возвращает токен.
```ruby
result = client.funcaptcha({
   publickey: "69A21A01-CC7B-B9C6-0F9A-E7FA06677FFC",
   pageurl: "https://mysite.com/page/with/funcaptcha",
   surl: "https://client-api.arkoselabs.com"})
```

### GeeTest
Метод для решения головоломки GeeTest captcha. Он возвращает набор токенов в формате JSON.
```ruby
result = client.geetest({
  gt: 'f1ab2cdefa3456789012345b6c78d90e',
  api_server: 'api-na.geetest.com',
  challenge: '12345678abc90123d45678ef90123a456b',
  pageurl: 'https://www.site.com/page/'
})
```

### hCaptcha
Метод решения hCaptcha. Он возвращает токен для обхода капчи.
```ruby
result = client.hcaptcha({
  sitekey: '10000000-ffff-ffff-ffff-000000000001',
  pageurl: 'https://www.site.com/page/'
})
```

### KeyCaptcha
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
Метод основан на использовании токенов для обхода паззла Capy.
```ruby
result = client.capy({
  sitekey: 'PUZZLE_Abc1dEFghIJKLM2no34P56q7rStu8v',
  pageurl: 'http://mysite.com/',
  api_server: 'https://jp.api.capy.me/'
})
```

### Grid
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
Используйте этот метод для решения задания hCaptcha. Он возвращает JSON-ответ с указанными значениями: ответ (answer) и идентификатор задания (challenge_id).
```ruby
result = client.lemin({
  captcha_id: 'CROPPED_1abcd2f_a1234b567c890d12ef3a456bc78d901d',
  div_id: 'lemin-cropped-captcha',
  pageurl: 'https://www.site.com/page/',
  api_server: "https://api.leminnow.com/"
})
```

### Cloudflare Turnstile
Используйте этот метод для решения задачи Cloudflare Turnstile. Он возвращает JSON с токеном.
```ruby
result = client.turnstile({
  sitekey: '0x1AAAAAAAAkg0s2VIOD34y5',
  pageurl: 'http://mysite.com/'
})
```

### Amazon WAF
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

### GeeTest v4
Используйте этот метод для решения GeeTest v4. Он возвращает ответ в формате JSON.
```ruby
result = client.geetest_v4({
  captcha_id: 'e392e1d7fd421dc63325744d5a2b9c73',
  pageurl: 'https://www.site.com/page/'
})
```

### Audio
Этот метод можно использовать для решения аудио-капчи.
```ruby
result = client.audio({
  audio: 'path/to/audio.jpg',
  lang: "en"
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
Используйте этот метод, чтобы посмотреть баланс в вашем аккаунте.
```ruby
balance = client.get_balance
```

### Отчет
Используйте этот метод для отправки отчета о правильном или неправильном ответе на капчу.
```ruby
client.report(captcha_id, True) # капча решена правильно
client.report(captcha_id, False) # капча решена неправильно
```

### Обработка ошибок
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
