" Compile and run g++/C++14 current file
nnoremap <C-c> :!g++ -o  %:r.out % -std=c++17 <CR>
nnoremap <C-x> :!./%:r.out<CR>
