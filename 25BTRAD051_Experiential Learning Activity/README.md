# StudyVerse

**Kaviya Dharshini S · 25BTRAD051**

StudyVerse is an academic study app for organizing course documents, searching notes, practicing recall, and scheduling revision. The project includes a Streamlit interface, a FastAPI backend, and an offline prototype.

## Features

- Import PDF, DOCX, and PPTX study materials
- Search indexed content and view source passages with page references
- Create practice cards and track spaced revision
- Keep application data local when using the offline prototype

## Run the main app on Windows

Install Python, open PowerShell in this folder, and run:

```powershell
python -m venv .venv
.\.venv\Scripts\python.exe -m pip install -r .\requirements.txt
.\.venv\Scripts\python.exe -m streamlit run .\app.py
```

The frontend connects to a FastAPI service. Start it separately by following [`backend/README.md`](backend/README.md). The standalone offline prototype has its own instructions in [`studyverse_offline/README.md`](studyverse_offline/README.md).

## Project materials

- [`PROJECT_SUMMARY.md`](PROJECT_SUMMARY.md) — overview
- [`PROJECT_REPORT.md`](PROJECT_REPORT.md) and [`PROJECT_REPORT_STUDYVERSE.docx`](PROJECT_REPORT_STUDYVERSE.docx) — report materials
- [`PRESENTATION_SLIDES.md`](PRESENTATION_SLIDES.md) — presentation outline
- [`OUTPUT/`](OUTPUT/) — application screenshots

The reports and screenshots are included as supplied project materials. The local SQLite database and Python caches are excluded; the app creates its database when needed.

[Back to the repository guide](../README.md)