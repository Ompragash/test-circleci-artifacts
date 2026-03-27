#!/usr/bin/env bash

set -euo pipefail

ARTIFACT_ROOT=/tmp/circleci-artifacts-demo

rm -rf "${ARTIFACT_ROOT}"
mkdir -p \
  "${ARTIFACT_ROOT}/logs" \
  "${ARTIFACT_ROOT}/manifest" \
  "${ARTIFACT_ROOT}/media" \
  "${ARTIFACT_ROOT}/nested/deeper" \
  "${ARTIFACT_ROOT}/reports/data" \
  "${ARTIFACT_ROOT}/site"

cat > "${ARTIFACT_ROOT}/site/index.html" <<'HTML'
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>CircleCI Artifact Browser Demo</title>
  <style>
    :root {
      color-scheme: light;
      --bg: #f5f1e8;
      --card: #fffdf8;
      --ink: #1f2933;
      --muted: #5b6770;
      --accent: #0f766e;
      --border: #d9d2c3;
    }

    body {
      margin: 0;
      font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
      background: linear-gradient(180deg, #efe7d6 0%, var(--bg) 100%);
      color: var(--ink);
    }

    main {
      max-width: 860px;
      margin: 40px auto;
      padding: 24px;
    }

    .card {
      background: var(--card);
      border: 1px solid var(--border);
      border-radius: 16px;
      padding: 24px;
      box-shadow: 0 10px 30px rgba(31, 41, 51, 0.08);
    }

    h1, h2 {
      margin-top: 0;
    }

    p, li {
      line-height: 1.6;
    }

    code {
      background: #efe7d6;
      border-radius: 4px;
      padding: 0.1rem 0.35rem;
    }

    ul {
      padding-left: 1.2rem;
    }

    .swatch {
      display: inline-block;
      width: 12px;
      height: 12px;
      margin-right: 8px;
      border-radius: 999px;
      background: var(--accent);
    }
  </style>
</head>
<body>
  <main>
    <section class="card">
      <h1>CircleCI Artifact Browser Demo</h1>
      <p>This HTML file was uploaded as part of a bulk directory artifact upload.</p>
      <p>Use the Artifacts tab to open these files individually and confirm nested paths are preserved:</p>
      <ul>
        <li><code>bulk-upload-demo/site/index.html</code></li>
        <li><code>bulk-upload-demo/media/diagram.svg</code></li>
        <li><code>bulk-upload-demo/media/pixel.png</code></li>
        <li><code>bulk-upload-demo/reports/data/sample.json</code></li>
        <li><code>bulk-upload-demo/reports/data/sample.csv</code></li>
        <li><code>bulk-upload-demo/reports/report.xml</code></li>
        <li><code>bulk-upload-demo/logs/build.log</code></li>
        <li><code>bulk-upload-demo/nested/deeper/notes.txt</code></li>
        <li><code>bulk-upload-demo/manifest/tree.txt</code></li>
      </ul>
      <h2>What this proves</h2>
      <p><span class="swatch"></span>Directory uploads keep subfolder structure.</p>
      <p><span class="swatch"></span>Browser-friendly files can be opened directly from the artifact list.</p>
      <p><span class="swatch"></span><code>destination: bulk-upload-demo</code> adds a stable prefix to the uploaded paths.</p>
    </section>
  </main>
</body>
</html>
HTML

cat > "${ARTIFACT_ROOT}/media/diagram.svg" <<'SVG'
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 720 360">
  <rect width="720" height="360" fill="#f5f1e8"/>
  <rect x="36" y="36" width="648" height="288" rx="24" fill="#fffdf8" stroke="#d9d2c3" stroke-width="4"/>
  <text x="60" y="90" font-family="Helvetica, Arial, sans-serif" font-size="28" fill="#1f2933">CircleCI bulk artifact upload</text>
  <rect x="80" y="130" width="150" height="60" rx="14" fill="#0f766e"/>
  <text x="106" y="168" font-family="Helvetica, Arial, sans-serif" font-size="22" fill="#ffffff">config.yml</text>
  <path d="M240 160 H340" stroke="#1f2933" stroke-width="6" stroke-linecap="round"/>
  <polygon points="340,160 320,148 320,172" fill="#1f2933"/>
  <rect x="360" y="110" width="150" height="100" rx="14" fill="#f59e0b"/>
  <text x="390" y="156" font-family="Helvetica, Arial, sans-serif" font-size="22" fill="#1f2933">directory</text>
  <text x="380" y="182" font-family="Helvetica, Arial, sans-serif" font-size="22" fill="#1f2933">upload</text>
  <path d="M520 160 H620" stroke="#1f2933" stroke-width="6" stroke-linecap="round"/>
  <polygon points="620,160 600,148 600,172" fill="#1f2933"/>
  <rect x="540" y="230" width="120" height="46" rx="12" fill="#ffffff" stroke="#d9d2c3" stroke-width="3"/>
  <text x="562" y="260" font-family="Helvetica, Arial, sans-serif" font-size="18" fill="#1f2933">Artifacts</text>
</svg>
SVG

base64 -d > "${ARTIFACT_ROOT}/media/pixel.png" <<'BASE64'
iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mP8/x8AAusB9WnWm0cAAAAASUVORK5CYII=
BASE64

cat > "${ARTIFACT_ROOT}/reports/data/sample.json" <<'JSON'
{
  "job": "artifact-browser-demo",
  "upload_mode": "bulk-directory",
  "artifact_prefix": "bulk-upload-demo",
  "open_in_browser": [
    "site/index.html",
    "media/diagram.svg",
    "media/pixel.png",
    "reports/data/sample.json",
    "reports/data/sample.csv",
    "reports/report.xml",
    "logs/build.log",
    "nested/deeper/notes.txt"
  ]
}
JSON

cat > "${ARTIFACT_ROOT}/reports/data/sample.csv" <<'CSV'
file_type,path,browser_expectation
html,site/index.html,rendered page
svg,media/diagram.svg,rendered vector image
png,media/pixel.png,rendered image
json,reports/data/sample.json,raw text/JSON
csv,reports/data/sample.csv,raw text/CSV
xml,reports/report.xml,raw text/XML
txt,nested/deeper/notes.txt,raw text
log,logs/build.log,raw text
CSV

cat > "${ARTIFACT_ROOT}/reports/report.xml" <<'XML'
<?xml version="1.0" encoding="UTF-8"?>
<artifactReport>
  <name>CircleCI Artifact Demo</name>
  <result>success</result>
  <pathPrefix>bulk-upload-demo</pathPrefix>
</artifactReport>
XML

cat > "${ARTIFACT_ROOT}/nested/deeper/notes.txt" <<'TXT'
This text file lives two levels below the artifact root.
If you can open this from the Artifacts tab, nested directories were preserved.
TXT

cat > "${ARTIFACT_ROOT}/logs/build.log" <<'LOG'
[artifact-browser-demo] generating nested artifact bundle
[artifact-browser-demo] writing HTML, SVG, PNG, JSON, CSV, XML, and TXT examples
[artifact-browser-demo] uploading /tmp/circleci-artifacts-demo as a single directory artifact source
LOG

(
  cd "${ARTIFACT_ROOT}"
  find . -type f | LC_ALL=C sort | sed 's#^\./##'
) > "${ARTIFACT_ROOT}/manifest/tree.txt"

echo "Artifact bundle contents:"
cat "${ARTIFACT_ROOT}/manifest/tree.txt"
