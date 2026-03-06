import os
import subprocess

def check_command(cmd):
    try:
        subprocess.run([cmd, "--version"], capture_output=True, check=True)
        return True
    except:
        return False

potential_cmds = ["lua", "luajit", "nvim", "lua5.1", "lua5.2", "lua5.3", "lua5.4"]
for cmd in potential_cmds:
    print(f"{cmd}: {check_command(cmd)}")

print("PATH:", os.environ.get("PATH"))
