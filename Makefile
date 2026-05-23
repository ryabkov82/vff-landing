SERVER ?= ru-msk-1
REMOTE_DIR ?= /var/www/mysite

deploy:
	rsync -avz --delete ./ $(SERVER):$(REMOTE_DIR)/ \
		--exclude .git \
		--exclude .gitignore \
		--exclude Makefile \
		--exclude README.md

dry-run:
	rsync -avz --delete --dry-run ./ $(SERVER):$(REMOTE_DIR)/ \
		--exclude .git \
		--exclude .gitignore \
		--exclude Makefile \
		--exclude README.md
