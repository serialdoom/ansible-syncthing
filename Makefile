#
# Makefile
# mchristof, 2016-09-25 14:11
#

default: up provision

up:
	vagrant up --no-provision

ui:
	open http://$$(vagrant ssh box1 -- ifconfig eth1 | grep 'inet addr' | cut -d ':' -f2 | cut -d ' ' -f1):8384
	open http://$$(vagrant ssh box2 -- ifconfig eth1 | grep 'inet addr' | cut -d ':' -f2 | cut -d ' ' -f1):8384

provision:
	vagrant provision

clean:
	vagrant destroy -f
all:
	@echo "Makefile needs your attention"


# vim:ft=make
#
