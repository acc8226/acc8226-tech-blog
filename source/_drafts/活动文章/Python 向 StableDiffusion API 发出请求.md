使用 Python 向 StableDiffusion API 发出请求。向应用程序的 txt2img（即文本到图像）API 发送 POST 请求以简单地生成图像。

我们将使用 requests 包，如果您还没有安装，请使用安装脚本：

pip install requests 

```py
import json
import base64
import requests
 
your_ip = '0.0.0.0' # HAI服务器 IP 地址
your_port =7862 # SD api 监听的端口
 
def submit_post(url: str,data: dict):
  """
  Submit a POST request to the given URL withthe given data.
  """
  return requests.post(url,data=json.dumps(data))
 
def save_encoded_image(b64_image: str,output_path: str):
  """
  Save the given image to the given outputpath.
  """
  with open(output_path,"wb") asimage_file:
      image_file.write(base64.b64decode(b64_image))
 
if __name__ == '__main__':
  #/sdapi/v1/txt2img
  txt2img_url = f'http://{your_ip}:{your_port}/sdapi/v1/txt2img'
  data = {
     'prompt': 'a pretty cat,cyberpunk art,kerem beyit,verycute robot zen,Playful,Independent,beeple |',
     'negative_prompt':'(deformed,distorted,disfigured:1.0),poorlydrawn,bad anatomy,wrong anatomy,extra limb,missing limb,floating limbs,(mutatedhands and fingers:1.5),disconnectedlimbs,mutation,mutated,ugly,disgusting,blurry,amputation,flowers,human,man,woman',
     'Steps':50,
     'Seed':1791574510
  }
  response = submit_post(txt2img_url,data)
  save_encoded_image(response.json()['images'][0],'cat.png')
```
