# test-circleci-artifacts

This repo is set up to test CircleCI bulk artifact uploads for a directory with nested subfolders and mixed file types.

The pipeline generates this artifact tree during the job and uploads it with a single `store_artifacts` step using `destination: bulk-upload-demo`:

- `site/index.html`
- `media/diagram.svg`
- `media/pixel.png`
- `reports/data/sample.json`
- `reports/data/sample.csv`
- `reports/report.xml`
- `logs/build.log`
- `nested/deeper/notes.txt`
- `manifest/tree.txt`

After the job passes, open the CircleCI job page and go to the `Artifacts` tab. The uploaded files should appear under the `bulk-upload-demo/` prefix with the nested folders preserved.

Good files to click in the browser:

- `bulk-upload-demo/site/index.html`
- `bulk-upload-demo/media/diagram.svg`
- `bulk-upload-demo/media/pixel.png`
- `bulk-upload-demo/reports/data/sample.json`
- `bulk-upload-demo/reports/data/sample.csv`
- `bulk-upload-demo/reports/report.xml`
- `bulk-upload-demo/logs/build.log`
- `bulk-upload-demo/nested/deeper/notes.txt`

Why it is structured this way:

- CircleCI’s `store_artifacts` step accepts a file or a directory `path`.
- `destination` adds a prefix to the artifact paths.
- CircleCI docs recommend compressing only when you are uploading a very large number of artifacts.
