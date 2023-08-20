FROM python:3.11.3-slim-buster AS base
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONFAULTHANDLER 1
RUN apt-get update && apt-get install -y libpq-dev gcc

FROM base AS python-deps
RUN pip install pipenv
COPY Pipfile .
COPY Pipfile.lock .
RUN PIPENV_VENV_IN_PROJECT=1 pipenv install --deploy

FROM base AS runtime
COPY --from=python-deps /.venv /.venv
ENV PATH="/.venv/bin:$PATH"
WORKDIR /main
COPY agent ./agent
COPY run.py ./run.py
RUN useradd --create-home agent
RUN chown agent:agent /main
USER agent

CMD ["python", "/main/run.py"]
