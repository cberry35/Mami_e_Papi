import io
from PIL import Image
import requests


# example image url: https://m.media-amazon.com/images/S/aplus-media/vc/6a9569ab-cb8e-46d9-8aea-a7022e58c74a.jpg
url = 'https://raw.githubusercontent.com/cberry35/Mami_e_Papi/main/Display_Images/mami.png'
image_file_path = "C:\\Users\\MyersB\\Desktop\\Tester.png"

def download_image(urlpath, path):
    r = requests.get(urlpath, stream=True)
    if r.status_code != requests.codes.ok:
        assert False, 'Status code error: {}.'.format(r.status_code)

    print(r.status_code)
    img = Image.open(r.raw)
    img.save(path)
    img.show

    print('Image downloaded from url: {} and saved to: {}.'.format(urlpath, path))


download_image(url, image_file_path)