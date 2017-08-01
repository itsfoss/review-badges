all:    css/review.css \
        css/bullet-good.png css/bullet-bad.png \
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

css/bullet-bad.png: assets/bullet-bad.png
	convert "$<" +level-colors '#e83000', -resize 16x16 png32:"$@"

css/bullet-good.png: assets/bullet-good.png
	convert "$<" +level-colors '#ffffff', -resize 16x16 png32:"$@"

assets/tux-happy.svg: assets/tux.svg
	cp "$<" "$@"

assets/tux-gold.svg: assets/tux.svg
	cp "$<" "$@"

#assets/bullet-%.png: assets/bullet-%.svg
#	inkscape --export-png="$@" --export-area-page --export-width=16 --export-height=16 "$<"

assets/%.png: assets/%.svg
	inkscape --export-png="$@" --export-area-page "$<"

