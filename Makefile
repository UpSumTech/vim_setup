all = CommandLoader.vim MappingLoader.vim PluginLoader.vim SettingLoader.vim vimrc
TARGET = $$HOME/Code/vim_setup_example

all: $(all)
	./build.sh

clean:
	$(RM) -rf $(TARGET)
