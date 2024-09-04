NAME = inception

$(NAME):
	@if [ ! -f srcs/.env ]; then \
		wget -P ./srcs/ https://github.com/nmep/Inception/raw/master/srcs/.env; \
	fi
	mkdir -p /home/lgarfi/data/mariadb /home/lgarfi/data/wordpress
	sudo docker-compose -f srcs/docker-compose.yml up --build -d

all: $(NAME)


clean:
	@if [ ! -f srcs/.env ]; then \
		wget -P ./srcs/ https://github.com/nmep/Inception/raw/master/srcs/.env; \
	fi
	sudo docker-compose -f srcs/docker-compose.yml down

fclean: clean
	rm -f ./srcs/.env
	sudo rm -rf /home/lgarfi/data
	sudo docker system prune -af


re: fclean all
