
# GetSystem-CLI

**GetSystem-CLI** is a PowerShell-based privilege escalation technique that allows you to escalate privileges from an Administrator account to `NT AUTHORITY\SYSTEM`. This is achieved by abusing the `Uninstall` scheduled task located under the `\Microsoft\Windows\LanguageComponentsInstaller` path, modifying its action, and executing it.

The `Uninstall` scheduled task is originally intended to assist with the uninstallation of language components in Windows, ensuring system language packages are managed effectively.

---

## ⚠️ Disclaimer

This project is intended for educational and ethical purposes only. Misuse of this technique can lead to serious consequences. Use responsibly and only in environments where you have explicit permission to test.

---

## Usage

### Prerequisites
- You need administrative privileges to modify the scheduled task.

### Script Parameters
- `BinaryPath`: Full path to the binary you want to execute with SYSTEM privileges.

### Example
```powershell
GetSystem-LCI -BinaryPath "C:\path\to\your\binary.exe"
```

---

### Note
For reasons not fully understood (and because I'm too lazy to figure out why), the task must be executed manually through the graphical interface of the Task Scheduler. The `Start-ScheduledTask` command does not successfully launch the task.

---

## How It Works

1. Checks for the existence of the `Uninstall` scheduled task:
   - **Task Name:** `Uninstall`
   - **Task Path:** `\Microsoft\Windows\LanguageComponentsInstaller`
2. Modifies the task's action to execute a specified binary.
3. Activates the task.
