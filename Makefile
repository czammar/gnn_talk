# COLORS
GREEN  := $(shell tput -Txterm setaf 2)
YELLOW := $(shell tput -Txterm setaf 3)
WHITE  := $(shell tput -Txterm setaf 7)
RESET  := $(shell tput -Txterm sgr0)

TARGET_MAX_CHAR_NUM=20

# Variables
UV := $(shell command -v uv 2> /dev/null)
PYTHON_VERSION := 3.11.14

.PHONY: all check-python-version get-python-version install sync clean help up down 

## Check is python version of the project
check-python-version:
	@test "$$(cat .python-version)" = "$(PYTHON_VERSION)" || \
		(echo ".python-version must be $(PYTHON_VERSION)"; exit 1)

## Download & pin python version for the project
get-python-version:
	uv python install $(PYTHON_VERSION)
	uv python pin $(PYTHON_VERSION)

## Show help with `make help`
help:
	@echo ''
	@echo 'Usage:'
	@echo '  ${YELLOW}make${RESET} ${GREEN}<target>${RESET}'
	@echo ''
	@echo 'Targets:'
	@awk '/^[a-zA-Z\-\_0-9]+:/ { \
		helpMessage = match(lastLine, /^## (.*)/); \
		if (helpMessage) { \
			helpCommand = substr($$1, 0, index($$1, ":")-1); \
			helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
			printf "  ${YELLOW}%-$(TARGET_MAX_CHAR_NUM)s${RESET} ${GREEN}%s${RESET}\n", helpCommand, helpMessage; \
		} \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST)

## Default action by executing `make` (install uv + sync)
all: install sync

## Installing uv
install:
ifdef UV
	@echo "✅ 'uv' ya está instalado en: $(UV)"
else
	@echo "📥 'uv' no fue detectado. Instalando mediante el script oficial..."
	@curl -LsSf https://astral.sh/uv/install.sh | sh
	@echo "⚠️  Nota: Si es la primera vez que instalas 'uv', es posible que necesites reiniciar tu terminal o recargar tu perfil (source ~/.zshrc o ~/.bashrc)."
endif

## Syncing project dependencies with uv
sync: get-python-version check-python-version 
	@echo "🔄 Sincronizando dependencias del proyecto con uv..."
	@if command -v uv > /dev/null; then \
		uv sync; \
	else \
		echo "❌ Error: 'uv' no está disponible en el PATH actual. Si lo acabas de instalar, ejecuta 'source ~/.zshrc' (o tu equivalente) e intenta de nuevo."; \
		exit 1; \
	fi
	@echo "🚀 Entorno virtual listo y actualizado."

## Cleaning the venv environment
clean:
	@echo "🧹 Eliminando el entorno virtual (.venv)..."
	@rm -rf .venv
	@echo "✨ Limpieza completada."

## Deploying Neo4j Server
up:
	docker compose up -d

## Stoping Neo4j Server
down:
	docker compose down
