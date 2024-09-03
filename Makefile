NAME = inception

$(NAME):
	mkdir -p /home/lgarfi/data/mariadb /home/lgarfi/data/wordpress
	sudo docker-compose -f srcs/docker-compose.yml up --build -d

all: $(NAME)


clean:
	sudo docker-compose -f srcs/docker-compose.yml down

fclean: clean
	sudo rm -rf /home/lgarfi/data
	sudo docker system prune -af


re: fclean all
