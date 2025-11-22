# COBOLcmp: COBOL Code Obfuscator and Compiler

## Overview

COBOLcmp is a project designed to **obfuscate COBOL source code** while maintaining its **functionality**. It takes a `.cob` file, applies transformations (like renaming variables and adding dummy comments), and outputs a new `.cob` file that is harder to read but still executable. The project also includes a helper tool to compile the obfuscated code using GnuCOBOL.

---

## Structure

```
COBOLcmp/
│
├── src/
│   ├── input.cob                 # Original COBOL source code
│   └── obfuscated_output.cob     # Obfuscated COBOL code
│
├── tools/
│   ├── -
│   └── helper.exe                # Executable version of helper.py
│
├── cobolcmp.cob                  # COBOL-based obfuscator
├── config.dat                    # Configuration file
└── README.md
```

---

## Components

### 1. `cobolcmp.cob`

- **Purpose**: The core obfuscator written in COBOL.
- **Functionality**:
  - Reads `src/input.cob`.
  - Renames variables (e.g., `WS-MESSAGE` → `VAR1000`).
  - Adds dummy comments like `*> Obfuscated by COBOLcmp`.
  - Writes the obfuscated code to `src/obfuscated_output.cob`.

### 2. `config.dat`

- **Purpose**: Stores configuration for the obfuscator.
- **Example**:
  ```
  INPUT_FILE=src/input.cob
  OUTPUT_FILE=src/obfuscated_output.cob
  OBFUSCATE_VARS=YES
  OBFUSCATE_COMMENTS=YES
  ```

### 3. `tools/helper.py`

-

### 4. `tools/helper.exe`

- **Purpose**: Standalone executable version of `helper.py`.
- **Creation**: Built using `pyinstaller --onefile helper.py`.

---

## How to Use

1. **Write your COBOL code** in `src/input.cob`.
2. **Run the COBOL obfuscator**:
   - Compile and run `cobolcmp.cob` using GnuCOBOL:
     ```bash
     cobc -x cobolcmp.cob
     ./cobolcmp
     ```
3. **Compile the obfuscated code**:
   - Run the helper:
     ```bash
     tools/helper.exe
     ```
   - Or manually:
     ```bash
     cobc -x src/obfuscated_output.cob
     ```

---

## Requirements

- **GnuCOBOL** installed and in your system's PATH.
- **Python** (for helper.py).
- **PyInstaller** (to create helper.exe).

---

Git: KilixKilik
