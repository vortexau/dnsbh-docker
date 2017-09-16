# dnsbh-docker
Docker DNS Black Hole

To build:

sudo docker build . -t dnsbh

To run: 

sudo docker run -d --restart=always --publish 53:53/tcp --publish 53:53/udp dnsbh 
