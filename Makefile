IMAGE=0xmjk/alpine-maria-db-server

image:
	docker build -t $(IMAGE) .
interactive:
	docker run -it -p 3306:3306 --rm --volume /data/mysql:/var/lib/mysql --entrypoint sh $(IMAGE)
run:
	docker run -d -p 3306:3306 --volume /data/mysql:/var/lib/mysql --name mysql $(IMAGE) 
stop:
	docker rm -f mysql
rm:
	docker ps -a | grep $(IMAGE) | awk '{print $$1}' | xargs docker rm

