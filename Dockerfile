# SecureNotes API — STUDENT Dockerfile
#
# Build the SecureNotes API into an image. Replace each TODO with a real Docker
# instruction. Check your structure as you go:
#     pytest tests/test_dockerfile.py        # (or: pytest tests/test_docker.py)
# Then build and run it for real:
#     docker build -t securenotes .
#     docker run -p 8000:8000 securenotes     # open http://localhost:8000/docs
#
# ---------------------------------------------------------------------------
# >>> TASK A1: start FROM a small, pinned, official Python image
#              (e.g. python:3.12-slim — never :latest)
FROM python:3.12-slim

# >>> TASK A2: set a WORKDIR (a home for the app inside the image, e.g. /app)
WORKDIR /app

# >>> TASK A3: copy requirements.txt in, then pip install it
#              Do this BEFORE copying your code, so Docker caches the install
#              and code edits don't reinstall everything.
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# >>> TASK A4: copy the rest of the source into the image
COPY . .

# >>> TASK B1: create a non-root user and switch to it with USER
#              (e.g. adduser --disabled-password --gecos "" appuser)
RUN adduser --disabled-password --gecos "" appuser
USER appuser

# >>> TASK A5: EXPOSE the port, then CMD to start the app with uvicorn.
#              Bind to 0.0.0.0 or nothing outside the container can reach it.
#              CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
EXPOSE 8000
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
