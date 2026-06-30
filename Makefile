SERVER ?= ru-msk-1
REMOTE_DIR ?= /var/www/mysite

RSYNC_EXCLUDES = \
	--exclude .git \
	--exclude .github \
	--exclude .gitignore \
	--exclude Makefile \
	--exclude README.md

guard:
	@test -f index.html || (echo "index.html not found. Run make from repo root"; exit 1)
	@test -f en/index.html || (echo "en/index.html not found. Run make from repo root"; exit 1)
	@test -f sitemap.xml || (echo "sitemap.xml not found. Run make from repo root"; exit 1)
	@test -d help || (echo "help directory not found. Run make from repo root"; exit 1)

dry-run: guard
	rsync -avz --delete --dry-run ./ $(SERVER):$(REMOTE_DIR)/ $(RSYNC_EXCLUDES)

deploy: guard
	rsync -avz --delete ./ $(SERVER):$(REMOTE_DIR)/ $(RSYNC_EXCLUDES)
	ssh $(SERVER) 'chown -R www-data:www-data $(REMOTE_DIR) && find $(REMOTE_DIR) -type d -exec chmod 755 {} \; && find $(REMOTE_DIR) -type f -exec chmod 644 {} \;'

check:
	curl -I https://vpn-for-friends.com/
	curl -I https://vpn-for-friends.com/en/
	curl -I https://vpn-for-friends.com/en/buy/
	curl -I https://vpn-for-friends.com/help/
	curl -I https://vpn-for-friends.com/sitemap.xml