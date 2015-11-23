############ Goals ############
.DEFAULT_GOAL := install

############ Vars and functions #############
ALL_FILES = CommandLoader.vim \
	MappingLoader.vim \
	PluginLoader.vim \
	SettingLoader.vim \
	plugins \
	vimrc

############ PHONY tasks #############
.PHONY: install

########### Public targets ############
install: $(ALL_FILES)
	@./build.sh
