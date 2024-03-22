.PHONY: help all lint test radon lock clean

help: # ignore checkmake
	@echo "Please use \`make <target>' where <target> is one of"
	@echo "  all       Run all tasks (lock, lint, test, radon)"
	@echo "  lint      Run linters using pre-commit"
	@echo "  test      Run tests using pytest"
	@echo "  radon     Run radon to check code complexity and maintainability"
	@echo "  lock      Generate and update the poetry lock file"
	@echo "  update    Update all dependencies to their latest version"

all: lock lint test radon

env:
	poetry run python --version
	poetry --version
	poetry show

setup:
	poetry install
	poetry run pre-commit install
	poetry run pre-commit install hooks

lint:
	poetry run pre-commit run --all-files

test:
	poetry run pytest

radon:
	poetry run radon cc --min C --total-average --order SCORE --include-ipynb src
	poetry run radon mi --min B src

lock:
	poetry lock

update:
	poetry update

clean:
	pre-commit clean
	poetry cache clear --all
	pre-commit install
	poetry install
