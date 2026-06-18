# Variables
UV := $(shell command -v uv 2> /dev/null)

.PHONY: all install sync clean

# Acción por defecto si solo ejecutas `make`
all: install sync

# 1. Instala uv si no está instalado
install:
ifdef UV
	@echo "✅ 'uv' ya está instalado en: $(UV)"
else
	@echo "📥 'uv' no fue detectado. Instalando mediante el script oficial..."
	@curl -LsSf https://astral.sh/uv/install.sh | sh
	@echo "⚠️  Nota: Si es la primera vez que instalas 'uv', es posible que necesites reiniciar tu terminal o recargar tu perfil (source ~/.zshrc o ~/.bashrc)."
endif

# 2. Ejecuta uv sync para aprovisionar el entorno
sync:
	@echo "🔄 Sincronizando dependencias del proyecto con uv..."
	@if command -v uv > /dev/null; then \
		uv sync; \
	else \
		echo "❌ Error: 'uv' no está disponible en el PATH actual. Si lo acabas de instalar, ejecuta 'source ~/.zshrc' (o tu equivalente) e intenta de nuevo."; \
		exit 1; \
	fi
	@echo "🚀 Entorno virtual listo y actualizado."

# Extra: Limpiar el entorno virtual por si necesitas recrearlo
clean:
	@echo "🧹 Eliminando el entorno virtual (.venv)..."
	@rm -rf .venv
	@echo "✨ Limpieza completada."