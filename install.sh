if command -v git &> /dev/null
then
  git clone git@github.com:ksnitsky/dot-files.git
else
  echo 'git not found. please install it and execute script again'
fi
# curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh
# ln
DOT_FILES_PATH=$(pwd)
# cd
echo $DOT_FILES_PATH
