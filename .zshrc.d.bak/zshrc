#                                 
# Zsh configuration file          
# Since 2009,  maethor <maethor@subiron.org>
#                                         
#  This file is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY                                    
#                                                      

#!/bin/zsh
setopt extendedglob

if [ -d $HOME/.zshrc.d ]
then for zshrc_file in `/bin/run-parts --test $HOME/.zshrc.d`
    do source $zshrc_file
    done
unset zshrc_file
fi

