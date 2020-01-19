SHELL=/bin/bash

SHELL_FILES=( 			\
	home/_.bash_profile \
	home/_.bashrc 		\
	home/_.colors 		\
	home/_.profile 		\
	home/_.ssh-agent 	\
	home/_.zshrc 		\
)

.PHONY:
format:
	SHELL_FILES=$(SHELL_FILES) && \
	shfmt -i 4 -w "$${SHELL_FILES[@]}"
