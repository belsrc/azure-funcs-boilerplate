
CROSSENV = ./node_modules/.bin/cross-env
AVA = ./node_modules/.bin/ava
ESLINT = ./node_modules/.bin/eslint
PRETTIER = ./node_modules/.bin/prettier
SECURITY = ./node_modules/.bin/nsp
UPDATE = ./node_modules/.bin/npm-check
BABEL = ./node_modules/.bin/babel
ROLLUP = ./node_modules/.bin/rollup

UNFORMAT = \033[0m
BOLD = \033[1m
BLUE = \033[34m
GREEN = \033[32m

#target: dependencies
#[tab] system command

# Default command. Checks package security, formats & lints code and builds assets
all: security test prettier lint_fix bundle complete

# Formats and lints code
dev: test prettier lint_fix complete

# Formats and lints code
clean: prettier lint_fix

# Run the unit tests for this project
test:
	@ printf "$(BOLD)$(BLUE)Running Unit Tests...$(UNFORMAT)\n"
	node $(AVA) --verbose
	@ printf "$(BOLD)$(GREEN)Unit Tests Complete!$(UNFORMAT)\n"

# Check packages against Node Security Platform
security:
	@ printf "$(BOLD)$(BLUE)Checking package security...$(UNFORMAT)\n"
	node $(SECURITY) check --output default
	@ printf "$(BOLD)$(GREEN)Security Check Complete!$(UNFORMAT)\n"

# Run Prettier
prettier:
	@ printf "$(BOLD)$(BLUE)Running Prettier...$(UNFORMAT)\n"
	node $(PRETTIER) --config .prettierrc --write "assets/js/{src,test}/**/*.js"
	@ printf "$(BOLD)$(GREEN)Prettier Complete!$(UNFORMAT)\n"

# Run ESLint (Show only errors)
lint_error:
	@ printf "$(BOLD)$(BLUE)Linting (Only Errors) Files...$(UNFORMAT)\n"
	node $(ESLINT) -c .eslintrc --color --quiet --ignore-path .eslintignore "assets/js/{src,test}/**/*.{js,vue}"
	@ printf "$(BOLD)$(GREEN)Linting Complete!$(UNFORMAT)\n"

# Run ESLint
lint:
	@ printf "$(BOLD)$(BLUE)Linting Files...$(UNFORMAT)\n"
	node $(ESLINT) -c .eslintrc --color --ignore-path .eslintignore "assets/js/{src,test}/**/*.{js,vue}"
	@ printf "$(BOLD)$(GREEN)Linting Complete!$(UNFORMAT)\n"

# Run ESLint --fix
lint_fix:
	@ printf "$(BOLD)$(BLUE)Linting Files...$(UNFORMAT)\n"
	node $(ESLINT) -c .eslintrc --fix --color --ignore-path .eslintignore "assets/js/{src,test}/**/*.{js,vue}"
	@ printf "$(BOLD)$(GREEN)Linting Complete!$(UNFORMAT)\n"

# Update node packages
update:
	@ printf "$(BOLD)$(BLUE)Checking Package Versions...$(UNFORMAT)\n"
	node $(UPDATE) -u
	@ printf "$(BOLD)$(GREEN)Update Complete!$(UNFORMAT)\n"

# Transpile Node 6.5 script
babel:
	@ printf "$(BOLD)$(BLUE)Transpiling to Node 6.5 Compatible Code...$(UNFORMAT)\n"
	node $(BABEL) src/index.js --out-file index.js
	@ printf "$(BOLD)$(GREEN)Transpile Complete!$(UNFORMAT)\n"

# Bundle code
bundle:
	@ printf "$(BOLD)$(BLUE)Bundling Code...$(UNFORMAT)\n"
	node $(CROSSENV) NODE_ENV=production $(ROLLUP) --config
	@ printf "$(BOLD)$(GREEN)Bundle Complete!$(UNFORMAT)\n"

# Completion message
complete:
	@ printf "$(BOLD)$(GREEN)Project was successfully built!$(UNFORMAT)\n"

# Help menu
help:
	@ echo
	@ echo '  Usage:'
	@ echo ''
	@ echo '    make <target> [flags...]'
	@ echo ''
	@ echo '  Targets:'
	@ echo ''
	@ awk '/^#/{ comment = substr($$0,3) } comment && /^[a-zA-Z][a-zA-Z0-9_-]+ ?:/{ print "   ", $$1, comment }' $(MAKEFILE_LIST) | column -t -s ':' | sort
	@ echo ''
	@ echo '  Flags:'
	@ echo ''
	@ awk '/^#/{ comment = substr($$0,3) } comment && /^[a-zA-Z][a-zA-Z0-9_-]+ ?\?=/{ print "   ", $$1, $$2, comment }' $(MAKEFILE_LIST) | column -t -s '?=' | sort
	@ echo ''

.PHONY: all dev clean test test_watch security prettier lint_error lint lint_fix assets complete help
