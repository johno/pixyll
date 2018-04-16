MAIN = ./assets/css/nicoespeon.css
MAIN_LESS = ./assets/less/nicoespeon.less
PRINT = ./assets/css/nicoespeon-print.css
PRINT_LESS = ./assets/less/nicoespeon-print.less
DATE = $(shell date +%I:%M\ %p)
CHECK = \033[32m✔\033[39m
HR=\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#

#
# BUILD CSS/JS
#

build:
	@echo "\n${HR}"
	@echo "Building front-end..."
	@echo "${HR}\n"
	@lessc --compress ${MAIN_LESS} ${MAIN}
	@echo "Compiling MAIN LESS...                 ${CHECK} Done"
	@lessc --compress ${PRINT_LESS} ${PRINT}
	@echo "Compiling PRINT LESS...                ${CHECK} Done"
	@echo "\n${HR}"
	@echo "Build successfully completed at ${DATE}."
	@echo "${HR}\n"
	@echo "Script by @nicoespeon,"
	@echo "inspired by @mdo's and @fat's Bootstrap Makefile\n"

#
# DEPLOY TO MASTER
#

deploy:
	@echo "\n${HR}"
	@echo "Deploying website..."
	@echo "${HR}\n"
	@jekyll build
	@echo "Generating files...                ${CHECK} Done"
	@git checkout master
	@echo "Switch to master...                ${CHECK} Done"
	@sudo cp -r _site/* . && sudo rm -rf _site/ en/_posts/ fr/_posts/ Makefile assets/less/ _data/ _plugins/ .idea/
	@echo "Updating files...                  ${CHECK} Done"
	@git add --all . && git commit -m "Regenerate files (jekyll deployment)"
	@echo "Committing files...                ${CHECK} Done"
	@git checkout develop && sudo git clean -f -d
	@echo "Switch back to develop...          ${CHECK} Done"
	@mkdir _site/ && jekyll build
	@echo "Re-generating files...             ${CHECK} Done"
	@echo "You can run back jekyll server now to follow changes"
	@echo "\n${HR}"
	@echo "Deployed successfully completed at ${DATE}."
	@echo "${HR}\n"
	@echo "Script by @nicoespeon"
