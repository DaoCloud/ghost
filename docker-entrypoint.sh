#!/bin/bash
set -e

if [[ "$*" == npm*start* ]]; then
	for dir in "$GHOST_SOURCE/content"/*/; do
		targetDir="$GHOST_CONTENT/$(basename "$dir")"
		mkdir -p "$targetDir"
		if [ -z "$(ls -A "$targetDir")" ]; then
			tar -c --one-file-system -C "$dir" . | tar xC "$targetDir"
		fi
	done

	if [ ! -e "$GHOST_CONTENT/config.js" ]; then
		sed -r '
			s/127\.0\.0\.1/0.0.0.0/g;
			s!path.join\(__dirname, (.)/content!path.join(process.env.GHOST_CONTENT, \1!g;
		' "$GHOST_SOURCE/config.example.js" > "$GHOST_CONTENT/config.js"
	fi

	ln -sf "$GHOST_CONTENT/config.js" "$GHOST_SOURCE/config.js"

	chown -R user "$GHOST_CONTENT"

	set -- gosu user "$@"
fi

if [ -d "/volume/ghost/images" ]; then
	rm -rf /usr/src/ghost/content/images
	ln -s /volume/ghost/images /usr/src/ghost/content/images
fi

if [ -d "/volume/ghost/apps" ]; then
	rm -rf /usr/src/ghost/content/apps
	ln -s /volume/ghost/apps /usr/src/ghost/content/apps
fi

if [ -d "/volume/ghost/data" ]; then
	rm -rf /usr/src/ghost/content/data
	ln -s /volume/ghost/data /usr/src/ghost/content/data
fi

if [ -d "/volume/ghost/themes" ]; then
	rm -rf /usr/src/ghost/content/themes
	ln -s /volume/ghost/themes /usr/src/ghost/content/themes
fi

exec "$@"
