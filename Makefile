ALL_FILES = CommandLoader.vim \
	MappingLoader.vim \
	PluginLoader.vim \
	SettingLoader.vim \
	plugins \
	vimrc

TARGET = $$HOME/Code/vim_setup_example

all: $(ALL_FILES)
	@./build.sh

clean:
	$(RM) -rf $(TARGET)
