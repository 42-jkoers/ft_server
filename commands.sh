
# compile
docker build -t ft_server .

# run deamon
docker run -d --rm -p 80:80 -p 443:443 ft_server


# run with terminal
docker run -it --rm -p 80:80 -p 443:443 ft_server
