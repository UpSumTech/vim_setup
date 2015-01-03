all = CommandLoader.vim MappingLoader.vim PluginLoader.vim SettingLoader.vim vimrc
TARGET = $$HOME/Code/vim_setup_example

all: $(all)
	./bootstrap.sh
	cd $(TARGET)

clean:
	$(RM) -rf $(TARGET)
