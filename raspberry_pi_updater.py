import io
from PIL import Image
import requests
import filecmp
import time

def download_image(urlpath, path):
    r = requests.get(urlpath, stream=True)
    if r.status_code != requests.codes.ok:
        assert False, 'Status code error: {}.'.format(r.status_code)

    print(r.status_code)
    img = Image.open(r.raw)
    img.save(path)

    return img


mamiurl = 'https://raw.githubusercontent.com/cberry35/Mami_e_Papi/main/Display_Images/mami.png'
papiurl = 'https://raw.githubusercontent.com/cberry35/Mami_e_Papi/main/Display_Images/papi.png'
image_file_path = "C:\\Users\\MyersB\\Desktop\\DisplayRaspImg.png"
image_file_path2 = "C:\\Users\\MyersB\\Desktop\\DisplayRaspImg2.png"




while(filecmp.cmp(image_file_path, image_file_path2, shallow=True) == False):
        time.sleep(10)
        download_image(mamiurl, image_file_path)
        download_image(papiurl, image_file_path2)
        print(filecmp.cmp(image_file_path, image_file_path2, shallow=True))