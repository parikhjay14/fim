# File Monitoring Script

This project provides two scripts for monitoring file integrity and changes in a specified directory (`Files`):
1. **PowerShell Script** (`file-monitor.ps1`)
2. **Bash Script** (`file-monitor.sh`)

These scripts allow users to:
- Collect a baseline of file hashes in a directory.
- Monitor the directory for file changes, additions, or deletions using the saved baseline.

---

## Prerequisites

### PowerShell Script
- PowerShell 5.0 or later

### Bash Script
- Bash shell
- `sha512sum` command-line utility

---

## Usage

### PowerShell Script

1. **Execution**:
   ```powershell
   ./file-monitor.ps1
   ```

2. **Workflow**:
   - **Option A: Collect New Baseline**
     - Deletes the existing `baseline.txt` if it exists.
     - Scans all files in the `Files` directory and calculates their SHA512 hashes.
     - Saves the hashes to `baseline.txt`.
   - **Option B: Begin Monitoring Files with Saved Baseline**
     - Loads the file hashes from `baseline.txt`.
     - Continuously monitors the `Files` directory for:
       - **New Files**: Alerts when a new file is added.
       - **File Changes**: Alerts when an existing file's content is modified.
       - **File Deletions**: Alerts when a file in the baseline is deleted.

3. **Example**:
   ```
   What would you like to do?
       A) Collect new Baseline?
       B) Begin monitoring files with saved Baseline?
   Please enter 'A' or 'B': A
   ```

---

### Bash Script

1. **Execution**:
   ```bash
   ./file-monitor.sh
   ```

2. **Workflow**:
   - **Option A: Collect New Baseline**
     - Deletes the existing `baseline.txt` if it exists.
     - Scans all files in the `Files` directory and calculates their SHA512 hashes using `sha512sum`.
     - Saves the hashes to `baseline.txt`.
   - **Option B: Begin Monitoring Files with Saved Baseline**
     - Loads the file hashes from `baseline.txt` into an associative array.
     - Continuously monitors the `Files` directory for:
       - **New Files**: Alerts when a new file is added.
       - **File Changes**: Alerts when an existing file's content is modified.
       - **File Deletions**: Alerts when a file in the baseline is deleted.

3. **Example**:
   ```
   What would you like to do?
       A) Collect new Baseline?
       B) Begin monitoring files with saved Baseline?
   Please enter 'A' or 'B: B
   ```

---

## File Structure

```
.
├── file-monitor.ps1   # PowerShell script
├── file-monitor.sh    # Bash script
├── baseline.txt       # Generated during baseline collection
└── Files/             # Directory containing target files for monitoring
```

---

## Notes

- Ensure that the `Files` directory exists and contains the files to be monitored.
- Both scripts create or overwrite the `baseline.txt` file in the current directory when the baseline is collected.
- Modify file paths or directory names in the scripts if necessary.
- Use appropriate color codes for enhanced visual output in the Bash script if required.

---

## License

This project is released under the MIT License. Feel free to use and modify the scripts as needed.

