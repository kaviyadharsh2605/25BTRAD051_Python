# SignBridge Dataset

These archives contain landmark sequences and label arrays used by the project. Extraction is optional when running the included saved model. Prepare the data before evaluating it or training from the saved arrays.

| Archive | Contents | Destination |
| --- | --- | --- |
| `raw(1).zip` | First group of per-gesture sample directories | `dataset/raw/` |
| `raw(2).zip` | Remaining per-gesture sample directories | The same `dataset/raw/` directory |
| `X.7z` | `X.npy` feature array | `dataset/processed/` |
| `y.zip` | `y.npy` labels | `dataset/processed/` |
| `X_test&Y_test.zip` | `X_test.npy` and `y_test.npy` | `dataset/processed/` |

## Extract on Windows

Run from the SignBridge application folder. PowerShell can extract ZIP files:

```powershell
New-Item -ItemType Directory -Force .\dataset\raw, .\dataset\processed | Out-Null
Expand-Archive -LiteralPath '.\dataset\raw(1).zip' -DestinationPath .\dataset\raw -Force
Expand-Archive -LiteralPath '.\dataset\raw(2).zip' -DestinationPath .\dataset\raw -Force
Expand-Archive -LiteralPath '.\dataset\y.zip' -DestinationPath .\dataset\processed -Force
Expand-Archive -LiteralPath '.\dataset\X_test&Y_test.zip' -DestinationPath .\dataset\processed -Force
```

Extract `X.7z` with 7-Zip into `dataset/processed/`. If 7-Zip is installed in its usual Windows location:

```powershell
& "$env:ProgramFiles\7-Zip\7z.exe" e '.\dataset\X.7z' '-o.\dataset\processed' -y
```

The final layout should be:

```text
dataset/
  raw/
    HELLO/
    NAMASTE/
    ... other gesture folders
  processed/
    X.npy
    y.npy
    X_test.npy
    y_test.npy
```

Do not put each archive in a separate extra subfolder. The scripts expect the four processed arrays directly under `processed/`. Keep the raw sample groups together under `raw/`.

## Generating and evaluating data

The training loader reads compatible `X.npy` and `y.npy` arrays. If those are absent or their class count does not match the label list, it generates synthetic landmarks. Training also writes a test split and replaces the checkpoint.

Evaluation uses the explicit test arrays when present. Without them, it falls back to the full processed dataset, which is not a held-out evaluation. Keep training and test data separate when reporting results, and do not equate synthetic-data performance with natural webcam signing performance.

Extracted data is ignored by Git; the original archives remain tracked. See the [application guide](../README.md) for training and evaluation commands.
