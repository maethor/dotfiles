import os
import time


def raw_acpi():
    return os.popen("acpi").read()

def acpi(acpi_str=None):
    if not acpi_str:
        acpi_str = raw_acpi()
    data = []
    for response in acpi_str.split("\n"):
        try:               battery, response = response.split(": ", 1)
        except ValueError: break
        status, response = response.split(", ", 1)
        if status in ("Full", "Unknown"):
            level = int(response.strip("%"))
            uptime = None
            str_uptime = None
        else:
            raw_level, response = response.split(", ", 1)
            level = int(raw_level.strip("%"))
            response_split = response.split(" ")
            try:
                str_uptime = response_split[0]
                struct_uptime = time.strptime(str_uptime, "%H:%M:%S")
                uptime = 3600*struct_uptime.tm_hour + 60*struct_uptime.tm_min + struct_uptime.tm_sec
            except ValueError:
                str_uptime = None
                uptime = None
        data.append((battery, status, level, uptime, str_uptime))
    return data
