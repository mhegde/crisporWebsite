git:
	sed -i '1 s|^.*$$|#!/usr/bin/env python2.7|' crispor.cgi
dev:
	sed -i '1 s|^.*$$|#!/cluster/software/bin/python2.7|' crispor.cgi

commit:
	make git; git add crispor.cgi; git commit; make dev;

pushNew:
	mkdir -p /data/www/crispor.new
	rsync -lrvp --exclude=.git /data/www/crisporBeta/ /data/www/crispor.new/ --exclude=crispor.conf
	#	
	cd /data/www/crisporBeta && ./stopWorkers.sh
	cd /data/www/crispor && ./stopWorkers.sh
	#
	mv /data/www/crispor /data/www/crispor.old
	mv /data/www/crispor.new /data/www/crispor
	#
	cd /data/www/crispor && ./startWorkers.sh
	cd /data/www/crisporBeta && ./startWorkers.sh

push:
	cd /data/www/crispor && ./stopWorkers.sh
	rsync -lrvp --exclude=.git /data/www/crisporBeta/ /data/www/crispor/ --exclude=crispor.conf
	cd /data/www/crispor && ./startWorkers.sh

pushOne:
	sudo cp crispor.py /data/www/crispor/
