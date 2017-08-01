all:    css/review.css \
        css/badge-happy-medium.png css/badge-sad-medium.png css/badge-gold-medium.png

clean:
	rm css/*

serve:  all
	echo "Point your browser to http://localhost:3100/test"
	python -m SimpleHTTPServer 3100

css/%.css: less/%.less
	lessc "$<" "$@"

css/badge-%-large.png:    assets/badge-%.png assets/tux-%.png
	composite -gravity center $(word 2,$^) $(word 1,$^) "$@"

css/badge-%-medium.png: css/badge-%-large.png
	convert "$<" -resize 190x190 "$@"

assets/tux-happy.svg: assets/tux.svg
	cp "$<" "$@"

assets/tux-gold.svg: assets/tux.svg
	cp "$<" "$@"

assets/%.png: assets/%.svg
	inkscape --export-png="$@" --export-area-page "$<"

