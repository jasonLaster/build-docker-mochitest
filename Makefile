
build:
	docker build -t jasonlaster11/local-mc7 .

publish:
	docker push jasonlaster11/local-mc7

download:
	hg clone https://hg.mozilla.org/mozilla-central/ firefox
