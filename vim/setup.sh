# Pathogen
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

cd ~/.vim/bundle

git clone https://github.com/kien/ctrlp.vim.git
git clone https://github.com/scrooloose/nerdtree.git
git clone https://github.com/vim-syntastic/syntastic.git
git clone https://github.com/majutsushi/tagbar.git
git clone https://github.com/vim-airline/vim-airline.git
git clone https://github.com/tpope/vim-commentary.git
git clone https://github.com/easymotion/vim-easymotion.git
git clone https://github.com/tpope/vim-surround.git
