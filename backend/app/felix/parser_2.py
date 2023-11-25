from bs4 import BeautifulSoup
import requests as req

def parser(diagnos):
    response = req.post("https://icd.who.int/browse11/l-m/ru/ACSearch", data={"q": diagnos})
    if response.status_code == 200:
        # print(response.text)
        return response.text
    else:
        return None

html_content = parser("панкреатит")
# html_content = parser("холера")
# html_content = parser("Паратиф")
# print(html_content)

if html_content:
    soup = BeautifulSoup(html_content, 'html.parser')
    # print(soup)

    # Записываем содержимое soup в файл
    with open('index1_1.html', 'w', encoding='utf-8') as file:
        file.write(str(soup))

    # Если хотите убедиться, что файл был создан и записан
    print("Содержимое soup было записано в файл 'index2.html'")

    # Находим корневой div
    root_div = soup.find('div', {'class': 'ygtvchildren', 'id': 'ygtvc1'})
    print(root_div)
    

    if root_div:
        # Находим все ссылки с классом ygtvlabel
        labels = root_div.find_all('a', class_='ygtvlabel')

        # Извлекаем текст из каждой ссылки
        for label in labels:
            text = label.get_text(strip=True)
            print(text)
else:
    print("Не получилось найти данные.")
