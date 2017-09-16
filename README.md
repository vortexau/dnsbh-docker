# dnsbh-docker
Docker DNS Black Hole

To run: 
sudo docker run -d --restart=always --publish 53:53/tcp --publish 53:53/udp dnsbh 
